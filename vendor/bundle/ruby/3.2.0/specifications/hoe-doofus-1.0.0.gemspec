# -*- encoding: utf-8 -*-
# stub: hoe-doofus 1.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "hoe-doofus".freeze
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["John Barnette".freeze]
  s.date = "2009-07-03"
  s.description = "A Hoe plugin that helps me (and you, maybe?) keep from messing up gem\nreleases. It shows a configurable checklist when <tt>rake release</tt>\nis run, and provides a chance to abort if anything's been forgotten.".freeze
  s.email = ["jbarnette@rubyforge.org".freeze]
  s.extra_rdoc_files = ["Manifest.txt".freeze, "CHANGELOG.rdoc".freeze, "README.rdoc".freeze]
  s.files = ["CHANGELOG.rdoc".freeze, "Manifest.txt".freeze, "README.rdoc".freeze]
  s.homepage = "http://github.com/jbarnette/hoe-doofus".freeze
  s.rdoc_options = ["--main".freeze, "README.rdoc".freeze]
  s.rubygems_version = "3.4.18".freeze
  s.summary = "A Hoe plugin that helps me (and you, maybe?) keep from messing up gem releases".freeze

  s.installed_by_version = "3.4.18" if s.respond_to? :installed_by_version

  s.specification_version = 3

  s.add_development_dependency(%q<hoe>.freeze, [">= 2.3.1"])
end
