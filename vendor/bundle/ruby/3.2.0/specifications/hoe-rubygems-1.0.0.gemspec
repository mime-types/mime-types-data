# -*- encoding: utf-8 -*-
# stub: hoe-rubygems 1.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "hoe-rubygems".freeze
  s.version = "1.0.0".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["John Barnette".freeze]
  s.date = "2009-09-25"
  s.description = "A Hoe plugin with additional RubyGems tasks. Provides support for\ngenerating gemspec files and installing with a prefix.".freeze
  s.email = ["jbarnette@rubyforge.org".freeze]
  s.extra_rdoc_files = ["Manifest.txt".freeze, "CHANGELOG.rdoc".freeze, "README.rdoc".freeze]
  s.files = ["CHANGELOG.rdoc".freeze, "Manifest.txt".freeze, "README.rdoc".freeze]
  s.homepage = "http://github.com/jbarnette/hoe-rubygems".freeze
  s.rdoc_options = ["--main".freeze, "README.rdoc".freeze]
  s.rubygems_version = "1.3.5".freeze
  s.summary = "A Hoe plugin with additional RubyGems tasks".freeze

  s.installed_by_version = "3.6.2".freeze

  s.specification_version = 3

  s.add_development_dependency(%q<hoe>.freeze, [">= 2.3.3".freeze])
end
