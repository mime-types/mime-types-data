# -*- encoding: utf-8 -*-
# stub: hoe-git2 1.8.0 ruby lib

Gem::Specification.new do |s|
  s.name = "hoe-git2".freeze
  s.version = "1.8.0".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "documentation_uri" => "http://docs.seattlerb.org/hoe-git", "homepage_uri" => "http://github.com/halostatue/hoe-git" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["John Barnette".freeze, "Austin Ziegler".freeze]
  s.date = "2023-02-17"
  s.description = "A set of Hoe plugins for tighter Git integration. Provides tasks to automate release tagging and pushing and changelog\ngeneration. I expect it'll learn a few more tricks in the future.\n\nThis is an evolution of +hoe-git+ by John Barnette, which has been archived at <http://github.com/jbarnette/hoe-git>.".freeze
  s.email = ["jbarnette@rubyforge.org".freeze, "halostatue@gmail.com".freeze]
  s.extra_rdoc_files = ["CHANGELOG.md".freeze, "Manifest.txt".freeze, "README.rdoc".freeze]
  s.files = ["CHANGELOG.md".freeze, "Manifest.txt".freeze, "README.rdoc".freeze]
  s.homepage = "http://github.com/halostatue/hoe-git".freeze
  s.licenses = ["MIT".freeze]
  s.rdoc_options = ["--main".freeze, "README.rdoc".freeze]
  s.rubygems_version = "3.3.26".freeze
  s.summary = "A set of Hoe plugins for tighter Git integration".freeze

  s.installed_by_version = "3.6.2".freeze

  s.specification_version = 4

  s.add_development_dependency(%q<hoe>.freeze, [">= 3.0".freeze, "< 5".freeze])
  s.add_development_dependency(%q<hoe-doofus>.freeze, ["~> 1.0".freeze])
  s.add_development_dependency(%q<hoe-gemspec2>.freeze, ["~> 1.1".freeze])
  s.add_development_dependency(%q<standard>.freeze, ["~> 1.0".freeze])
  s.add_development_dependency(%q<rdoc>.freeze, [">= 4.0".freeze, "< 7".freeze])
end
