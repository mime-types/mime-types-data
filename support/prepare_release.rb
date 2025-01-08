require_relative "apache_mime_types"
require_relative "convert"
require_relative "convert/columnar"
require_relative "convert/mini_mime_db"
require_relative "iana_registry"

class PrepareRelease
  def download_and_convert
    download_apache_mime_types
    download_iana_mime_types
    convert_types
    self
  end

  def write_updated_version
    file = IO.read("lib/mime/types/data.rb")
    updated = file.sub(/VERSION = ['"][.0-9]+['"]/, %(VERSION = "#{new_version}"))

    IO.write("lib/mime/types/data.rb", updated)
    self
  end

  def write_updated_history
    history = IO.read("CHANGELOG.md")

    if !/^## #{release_header}$/.match?(history)
      note = <<~NOTE
        <!-- automatic-release -->

        ## #{release_header}

        #{history_body}
      NOTE

      updated = history.sub("<!-- automatic-release -->\n", note)

      IO.write("CHANGELOG.md", updated)
    end

    self
  end

  def rake_git_manifest
    system("bundle exec rake git:manifest")
    self
  end

  def rake_gemspec
    system("bundle exec rake gemspec")
    self
  end

  def as_gha_vars
    unless ENV.key?("GITHUB_ENV")
      raise "This is not being run as a GitHub action, missing $GITHUB_ENV."
    end

    body = <<~EOF_ENV
      UPDATE_VERSION=#{new_version}
      UPDATE_TITLE=Update mime-types-data #{release_header}
      UPDATE_BODY=#{history_body}
    EOF_ENV

    File.write(ENV["GITHUB_ENV"], body, mode: "a+")

    self
  end

  def download_apache_mime_types(destination = nil)
    ApacheMIMETypes.download(to: destination)
  end

  def download_iana_mime_types(destination = nil)
    IANARegistry.download(to: destination)
  end

  def convert_yaml_to_json
    Convert.from_yaml_to_json
  end

  def convert_yaml_to_columnar
    Convert::Columnar.from_yaml_to_columnar
  end

  def convert_yaml_to_mini_mime_db
    Convert::MiniMimeDb.from_yaml_to_mini_mime
  end

  def convert_types
    convert_yaml_to_json
    convert_yaml_to_columnar
    convert_yaml_to_mini_mime_db
    self
  end

  def today
    @today ||= Date.today.strftime("%Y-%m-%d")
  end

  def release_header
    "#{new_version} / #{today}"
  end

  def new_version
    @new_version ||= begin
      version =
        IO.read("lib/mime/types/data.rb").scan(/VERSION = ['"](\d\.\d{4}\.\d{4}(?:\.\d+)?)['"]/).flatten.first

      major = Gem::Version.new(version).canonical_segments.first
      minor = Date.today.strftime("%Y.%m%d")

      "#{major}.#{minor}"
    end
  end

  def history_body
    "- Updated the Apache and IANA media registry entries as of release date"
  end
end
