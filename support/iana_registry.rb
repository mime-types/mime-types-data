# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

require "open-uri"
require "nokogiri"
require "cgi"
require "pathname"
require "yaml"

ENV["RUBY_MIME_TYPES_LAZY_LOAD"] = "yes"
require "mime/types/support"

# IANA Registry importing
class IANARegistry
  DEFAULTS = {
    url: "https://www.iana.org/assignments/media-types/media-types.xml",
    to: Pathname(__FILE__).join("../../types")
  }.freeze.each_value(&:freeze)

  def self.download(options = {})
    dest = Pathname(options[:to] || DEFAULTS[:to]).expand_path
    url = options.fetch(:url, DEFAULTS[:url])

    puts "Downloading IANA MIME type assignments."
    puts "\t#{url}"
    xml = Nokogiri::XML(URI.parse(url).open(&:read))

    xml.css("registry registry").each do |registry|
      next if registry.at_css("title").text == "example"

      new(registry: registry, to: dest) do |parser|
        puts "Extracting #{parser.type}/*."
        parser.parse
        parser.save
      end
    end
  end

  attr_reader :type

  def initialize(options = {})
    @registry = options.fetch(:registry)
    @to = Pathname(options.fetch(:to)).expand_path
    @type = @registry.at_css("title").text
    @name = "#{@type}.yaml"
    @file = @to.join(@name)
    @types = mime_types_for(@file)

    yield self if block_given?
  end

  ASSIGNMENT_FILE_REF = "{%s=http://www.iana.org/assignments/media-types/%s}"

  def parse
    @registry.css("record").each do |record|
      subtype = record.at_css("name").text
      obsolete = record.at_css("obsolete")&.text
      use_instead = record.at_css("deprecated")&.text

      if subtype =~ /OBSOLETE|DEPRECATE/i
        obsolete = true
        use_instead ||= Regexp.last_match(1) if subtype =~ /in favou?r of (.*)/
      end

      subtype, notes = subtype.split(/ /, 2)

      xrefs = parse_refs_and_files(
        record.css("xref"),
        record.css("file"),
        subtype
      )

      xrefs.add("notes", notes) if notes

      content_type = [@type, subtype].join("/")
      types = @types.select { |t| t.content_type.casecmp(content_type).zero? }

      if types.empty?
        MIME::Type.new(content_type) do |mt|
          mt.xrefs = xrefs
          mt.registered = true
          mt.obsolete = obsolete if obsolete
          mt.use_instead = use_instead if use_instead
          @types << mt
        end
      else
        types.each { |mt|
          mt.registered = true
          mt.xrefs = xrefs
          mt.obsolete = obsolete if obsolete
          mt.use_instead = use_instead if use_instead
        }
      end
    end
  end

  def save
    @to.mkpath
    File.open(@file, "wb") { |f| f.puts @types.map.to_a.sort.uniq.to_yaml }
  end

  private

  def mime_types_for(file)
    if file.exist?
      MIME::Types::Loader.load_from_yaml(file)
    else
      MIME::Types.new
    end
  end

  def parse_refs_and_files(refs, files, subtype)
    xr = MIME::Types::Container.new

    refs.each do |xref|
      type = xref["type"]
      data = xref["data"]

      next if data.nil? || data.empty?

      xr.add(type, data)
    end

    files.each do |file|
      file_name = if file.text == subtype
        [@type, subtype].join("/")
      else
        file.text
      end

      xr.add(file["type"], file_name)
    end

    xr
  end
end
