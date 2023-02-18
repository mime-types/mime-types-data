# frozen_string_literal: true

require "convert"

# Columnar conversion.
class Convert::MiniMimeDb < Convert
  class << self
    # Converts from YAML to MiniMime database format. This *always* converts to multiple
    # files.
    def from_yaml_to_mini_mime(args)
      from_yaml(yaml_path(args.source))
        .to_mini_mime_db(destination: data_path(args.destination))
    end
  end

  # Convert the data to multiple text files.
  def to_mini_mime_db(options = {})
    root = options[:destination] or require_destination!
    @root = must_be_directory!(root)
    @data = @loader.container.sort.map(&:to_h)

    index = {}
    @loader.container.each do |type|
      type.extensions.each { |ext| (index[ext.downcase] ||= []) << type }
    end

    index.each_pair do |_ext, list|
      list.sort! { |a, b| a.priority_compare(b) }
    end

    buffer = []

    index.each_pair do |ext, list|
      mime_type = list.detect { |t| !t.obsolete? }
      mime_type ||= list.detect(&:registered)
      mime_type ||= list.first
      buffer << [ext.dup, mime_type.content_type.dup, mime_type.encoding.dup]
    end

    pad(buffer)

    buffer.sort! { |a, b| a[0] <=> b[0] }

    n = File.join(root, "ext_mime.db")
    File.open(n, "wb") do |f|
      buffer.each { |(ext, type, encoding)| f.write "#{ext} #{type} #{encoding}\n" }
    end

    buffer.sort! { |a, b| [a[1], a[0]] <=> [b[1], b[0]] }
    buffer.each { |row| row.each { |col| col.strip! } }
    buffer.each do |row|
      row[0] = @loader.container.type_for("xyz.#{row[0].strip}")[0].extensions[0].dup
    end

    pad(buffer)

    n = File.join(root, "content_type_mime.db")
    File.open(n, "wb") do |f|
      last = nil
      buffer.each do |(ext, type, encoding)|
        f.write "#{ext} #{type} #{encoding}\n" unless last == type
        last = type
      end
    end
  end

  private

  def pad(array)
    max = []
    array.each do |row|
      i = 0
      row.each do |col|
        max[i] = [max[i] || 0, col.length].max
        i += 1
      end
    end

    array.each do |row|
      i = 0

      row.each do |col|
        col << " " * (max[i] - col.length)
        i += 1
      end
    end
  end
end
