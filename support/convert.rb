# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
ENV["RUBY_MIME_TYPES_LAZY_LOAD"] = "true"
require "mime/types/support"
require "fileutils"
require "json"

# Convert from YAML to JSON (and back) or columnar.
class Convert
  class << self
    # Create a Convert instance that converts from YAML.
    def from_yaml(path = nil)
      new(path: path, from: :yaml)
    end

    # Create a Convert instance that converts from JSON.
    def from_json(path = nil)
      new(path: path, from: :json)
    end

    # Create a Convert instance that converts from the mime-types 1.x file
    # format.
    def from_v1(path = nil)
      new(path: path, from: :v1)
    end

    # Converts from YAML to JSON. Defaults to converting to a single file.
    def from_yaml_to_json(from: nil, to: nil, multiple_files: false)
      from_yaml(to_yaml_path(from))
        .to_json(
          destination: to_data_path(to),
          multiple_files: to_multiple_files(multiple_files)
        )
    end

    # Converts from JSON to YAML. Defaults to converting to multiple files.
    def from_json_to_yaml(from: nil, to: nil, multiple_files: true)
      from_json(to_data_path(from))
        .to_yaml(
          destination: to_yaml_path(to),
          multiple_files: to_multiple_files(multiple_files)
        )
    end

    private :new

    private

    def to_yaml_path(path)
      to_path_or_default(path, "types")
    end

    def to_data_path(path)
      to_path_or_default(path, "data")
    end

    def to_path_or_default(path, default)
      if path.nil? || path.empty?
        default
      else
        path
      end
    end

    def to_multiple_files(flag)
      case flag.to_s.downcase
      when "true", "yes", "multiple"
        true
      else
        false
      end
    end
  end

  def initialize(options = {})
    raise ArgumentError, ":path is required" if options[:path].nil? || options[:path].empty?
    raise ArgumentError, ":from is required" if options[:from].nil? || options[:from].empty?

    @loader = MIME::Types::Loader.new(options[:path])
    load_from(options[:from])
  end

  # Convert the data to JSON.
  def to_json(options = {})
    options[:destination] or require_destination!
    write_types(options.merge(format: :json))
  end

  # Convert the data to YAML.
  def to_yaml(options = {})
    options[:destination] or require_destination!
    write_types(options.merge(format: :yaml))
  end

  private

  def load_from(source_type)
    method = :"load_#{source_type}"
    @loader.send(method)
  end

  def write_types(options)
    if options[:multiple_files]
      write_multiple_files(options)
    else
      write_one_file(options)
    end
  end

  def write_one_file(options)
    d = options[:destination]
    d = File.join(d, "mime-types.#{options[:format]}") if File.directory?(d)

    File.open(d, "wb") { |f|
      f.puts convert(@loader.container.map.sort, options[:format])
    }
  end

  def write_multiple_files(options)
    d = options[:destination]
    must_be_directory!(d)

    media_types = MIME::Types.map(&:media_type).uniq
    media_types.each { |media_type|
      n = File.join(d, "#{media_type}.#{options[:format]}")
      t = @loader.container.select { |e| e.media_type == media_type }
      File.open(n, "wb") { |f|
        f.puts convert(t.sort, options[:format])
      }
    }
  end

  def convert(data, format)
    data.send(:"to_#{format}")
  end

  def require_destination!
    raise ArgumentError, "Destination path is required."
  end

  def must_be_directory!(path)
    raise ArgumentError, "Cannot write multiple files to a file." if File.exist?(path) && !File.directory?(path)

    FileUtils.mkdir_p(path) unless File.exist?(path)
    path
  end
end
