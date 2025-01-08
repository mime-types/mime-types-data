# frozen_string_literal: true

require "rubygems"
require "hoe"
require "rake/clean"

$LOAD_PATH.unshift("lib")
$LOAD_PATH.unshift("support")

Hoe.plugin :halostatue

Hoe.plugins.delete :debug
Hoe.plugins.delete :newb
Hoe.plugins.delete :publish
Hoe.plugins.delete :signing

Hoe.spec "mime-types-data" do
  developer("Austin Ziegler", "halostatue@gmail.com")

  require_ruby_version ">= 2.0"

  license "MIT"

  spec_extras[:metadata] = ->(val) {
    val.merge!({"rubygems_mfa_required" => "true"})
  }

  extra_dev_deps << ["hoe", "~> 4.0"]
  extra_dev_deps << ["hoe-halostatue", "~> 1.0"]
  extra_dev_deps << ["mime-types", ">= 3.4.0", "< 4"]
  extra_dev_deps << ["nokogiri", "~> 1.6"]
  extra_dev_deps << ["rake", ">= 10.0", "< 14"]
  extra_dev_deps << ["standard", "~> 1.0"]
end

namespace :mime do
  desc "Download the current MIME type registrations from IANA."
  task :iana, [:destination] do |_, args|
    require "iana_registry"
    IANARegistry.download(to: args.destination)
  end

  desc "Download the current MIME type configuration from Apache."
  task :apache, [:destination] do |_, args|
    require "apache_mime_types"
    ApacheMIMETypes.download(to: args.destination)
  end
end

namespace :release do
  desc "Prepare a new release"
  task :prepare do
    require "prepare_release"

    PrepareRelease.new
      .download_and_convert
      .write_updated_version
      .write_updated_history
      .rake_git_manifest
      .rake_gemspec
  end

  desc "Prepare a new release for use with GitHub Actions"
  task :gha do
    require "prepare_release"

    PrepareRelease.new
      .download_and_convert
      .write_updated_version
      .write_updated_history
      .rake_git_manifest
      .rake_gemspec
      .as_gha_vars
  end
end

desc "Default conversion from YAML to JSON and Columnar"
task :convert do
  require "prepare_release"

  PrepareRelease.new.convert_types
end

Rake::Task["gem"].prerequisites.unshift("convert")
Rake::Task["gem"].prerequisites.unshift("git:manifest")
Rake::Task["gem"].prerequisites.unshift("gemspec")

# vim: syntax=ruby
