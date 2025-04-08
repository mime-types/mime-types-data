# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

require "open-uri"
require "nokogiri"
require "cgi"
require "pathname"
require "yaml"
require "English"

require "mime/types/support"

# Update MIME types from the Tika MIME types
class TikeMIMETypes
  DEFAULTS = {
    urls: ["https://github.com/apache/tika/raw/refs/heads/main/tika-core/src/main/resources/org/apache/tika/mime/tika-mimetypes.xml"],
    to: Pathname(__FILE__).join("../../types")
  }.freeze.each_value(&:freeze)

  def self.download(options = {})
    dest = Pathname(options[:to] || DEFAULTS[:to]).expand_path
    urls = options.fetch(:urls, DEFAULTS[:urls])

    puts "Downloading Apache Tika MIME type list."

    urls.each do |url|
      puts "\t#{url}"

      new(dest)
        .parse(Nokogiri::XML(URI.parse(url).open(&:read)).xpath("/mime-info/mime-type"))
        .save
    end
  end

  def initialize(to)
    @to = Pathname(to).expand_path
    @registries = {}
  end

  def parse(records)
    records.each do |record|
      content_type = record["type"]

      # Do not process any records where the subtype includes attributes like format or
      # version. MIME::Types is not built for this specific behaviour.
      next if content_type =~ /;/

      extensions = record.css("glob").map { |glob|
        if glob["isregex"]
          glob["pattern"].gsub(/\A\^|\$\z/, "")
        elsif glob["pattern"].start_with?("*.")
          glob["pattern"].sub(/^\*\./, "")
        elsif glob["pattern"] =~ /\A\.?[-\w]+\z/
          glob["pattern"]
        end
      }.compact.map(&:downcase)

      type, _ = content_type.split("/", 2)
      type.gsub!(/\Ax-/, "")

      registry = registry_for(type)

      existing_types = registry[:types].select { |t| t.content_type.casecmp(content_type).zero? }

      if existing_types.empty?
        MIME::Type.new(content_type) do |mt|
          mt.extensions = extensions
          registry[:types].add_type(mt, true)
        end
      else
        existing_types.each do |mt|
          mt.add_extensions(extensions)
        end
      end
    end

    self
  end

  def save
    @to.mkpath

    @registries.each_value { |registry|
      File.open(registry[:file], "wb") { |f|
        f.puts registry[:types]
          .map
          .to_a
          .sort { |a, b| a.content_type.casecmp(b.content_type) }
          .uniq
          .to_yaml
      }
    }
  end

  private

  def registry_for(type)
    unless @registries[type]
      name = "#{type}.yaml"
      file = @to.join(name)
      @registries[type] = {
        file: file,
        types: mime_types_for(file)
      }
    end

    @registries[type]
  end

  def mime_types_for(file)
    MIME::Types.new.tap do |container|
      if file.exist?
        container.add(*MIME::Types::Loader.load_from_yaml(file), :silent)
      end
    end
  end
end
