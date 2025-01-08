# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

require "cgi"
require "nokogiri"
require "open-uri"
require "pathname"
require "yaml"

require "mime/types/support"

# IANA Registry importing
class IANARegistry
  PROVISIONAL = "provisional-standard-types"
  DEFAULTS = {
    urls: %w[
      https://www.iana.org/assignments/media-types/media-types.xml
      https://www.iana.org/assignments/provisional-standard-media-types/provisional-standard-media-types.xml
    ],
    to: Pathname(__FILE__).join("../../types")
  }.freeze.each_value(&:freeze)

  USE_INSTEAD_RE = %r{in favou?r of ([a-zA-Z][-a-zA-Z0-9+_.]*/[a-zA-Z0-9][-a-zA-Z0-9+_.]*)}.freeze

  def self.download(options = {})
    dest = Pathname(options[:to] || DEFAULTS[:to]).expand_path
    urls = options.fetch(:urls, DEFAULTS[:urls])

    puts "Downloading IANA MIME type assignments."

    collection = {}

    urls.each do |url|
      puts "\t#{url}"
      xml = Nokogiri::XML(URI.parse(url).open(&:read))

      xml.css("registry registry").each do |registry|
        types = new(registry: registry, to: dest) do |parser|
          puts "Extracting #{parser.type}/*."
          parser.parse
        end

        collection[types.type] = types
      end
    end

    grouped_provisional = collection[PROVISIONAL].types.group_by(&:media_type)
    grouped_provisional.each_pair do |media_type, types|
      collection[media_type].merge_types(types)
    end

    collection.delete("examples")
    collection.delete(PROVISIONAL)

    collection.each_value(&:save)
  end

  attr_reader :type, :types

  def initialize(options = {})
    @registry = options.fetch(:registry)
    @to = Pathname(options.fetch(:to)).expand_path

    @type = @registry.attributes["id"].value
    @provisional = @type == PROVISIONAL
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
        use_instead ||= Regexp.last_match(1) if subtype =~ USE_INSTEAD_RE
      end

      subtype, notes = subtype.split(/ /, 2)

      xrefs = parse_refs_and_files(
        record.css("xref"),
        record.css("file"),
        subtype
      )

      xrefs.add("notes", notes) if notes

      content_type = @provisional ? subtype : [@type, subtype].join("/")
      existing_types = @types.select { |t| t.content_type.casecmp(content_type).zero? }

      if existing_types.empty?
        MIME::Type.new(content_type) do |mt|
          mt.xrefs = xrefs
          mt.registered = true
          mt.provisional = @provisional
          mt.obsolete = obsolete if obsolete
          mt.use_instead = use_instead if use_instead
          @types.add_type(mt, true)
        end
      else
        existing_types.each do |mt|
          mt.registered = true
          mt.xrefs = xrefs
          mt.obsolete = obsolete if obsolete
          mt.use_instead = use_instead if use_instead
        end
      end
    end
  end

  def save
    @to.mkpath
    File.open(@file, "wb") { |f| f.puts @types.map.to_a.sort.uniq.to_yaml }
  end

  def merge_types(other)
    other.each do |mt|
      existing_types = @types.select { |t| t.content_type.casecmp(mt.content_type).zero? }

      if existing_types.empty?
        @types.add_type(mt, true)
      else
        existing_types.each do |emt|
          emt.xrefs = mt.xrefs
          emt.registered = mt.registered
          emt.provisional = mt.provisional
          emt.provisional = mt.provisional
          emt.obsolete = mt.obsolete
          emt.use_instead = mt.use_instead
        end
      end
    end
  end

  private

  def mime_types_for(file)
    MIME::Types.new.tap do |container|
      if file.exist? && !@provisional
        container.add(*MIME::Types::Loader.load_from_yaml(file), :silent)
      end
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
