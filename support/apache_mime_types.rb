# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'open-uri'
require 'nokogiri'
require 'cgi'
require 'pathname'
require 'yaml'
require 'English'

ENV['RUBY_MIME_TYPES_LAZY_LOAD'] = 'yes'
require 'mime/types/support'

# Update MIME types from the Apache master list
class ApacheMIMETypes
  DEFAULTS = {
    url: %q(http://svn.apache.org/repos/asf/httpd/httpd/trunk/docs/conf/mime.types),
    to: Pathname(__FILE__).join('../../types')
  }.freeze.each_value(&:freeze)

  X_PREFIX_RE = /^x-/.freeze

  def self.download(options = {})
    dest = Pathname(options[:to] || DEFAULTS[:to]).expand_path
    url = options.fetch(:url, DEFAULTS[:url])

    puts 'Downloading Apache MIME type list.'
    puts "\t#{url}"
    data = URI.parse(url).open(&:read).split($INPUT_RECORD_SEPARATOR)
    data.delete_if { |line| line.start_with?('#') }

    conf = MIME::Types::Container.new

    data.each do |line|
      type = line.split(/\t+/)
      key = type.first.split(%r{/}).first.gsub(X_PREFIX_RE, '')
      conf.add(key, type)
    end

    conf.each do |type, types|
      next if type == 'example'

      new(type: type, registry: types, to: dest) do |parser|
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
    @type = options.fetch(:type)
    @name = "#{@type}.yaml"
    @file = @to.join(@name)
    @types = mime_types_for(@file)

    yield self if block_given?
  end

  def parse
    @registry.each do |record|
      content_type = record.first
      extensions = record.last.split(/\s+/)

      types = @types.select { |t| t.content_type.casecmp(content_type).zero? }

      if types.empty?
        MIME::Type.new(content_type) do |mt|
          mt.extensions = extensions
          mt.registered = false
          @types.add(mt)
        end
      else
        types.each { |mt|
          mt.extensions = (mt.extensions + extensions)
        }
      end
    end
  end

  def save
    @to.mkpath
    File.open(@file, 'wb') { |f| f.puts @types.map.to_a.sort.to_yaml }
  end

  private

  def mime_types_for(file)
    if file.exist?
      MIME::Types::Loader.load_from_yaml(file)
    else
      MIME::Types.new
    end
  end
end
