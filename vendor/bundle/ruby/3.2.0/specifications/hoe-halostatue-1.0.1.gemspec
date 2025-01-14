# -*- encoding: utf-8 -*-
# stub: hoe-halostatue 1.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "hoe-halostatue".freeze
  s.version = "1.0.1".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Austin Ziegler".freeze]
  s.date = "2024-12-31"
  s.description = "Hoe::Halostatue is a [Hoe][hoe] meta-plugin that ensures that the following\nplugins are installed and enabled for your project:\n\n- [`hoe-doofus`][hoe-doofus]\n- [`hoe-gemspec2`][hoe-gemspec2]\n- [`hoe-git2`][hoe-git2]\n- [`hoe-markdown`][hoe-markdown]\n- [`hoe-rubygems`][hoe-rubygems]\n\nIt also provides an improved implementation for `Hoe#parse_urls` that works\nbetter with a Markdown README. It allows either `*` or `-` as list leaders for\nthe README. It also allows the URLs to be blank. Double colons are still\nrequired for pattern matching.\n\nIn addition to the four letter aliases in `Hoe::URLS_TO_META_MAP` (`bugs`,\n`clog`, `doco`, `docs`, `home`, `code`, `wiki`, and `mail`), this adds:\n\n- `changelog`, `changes`, and `history` as aliases for `changelog_uri`\n- `documentation` for `documentation_uri`\n- `issues` and `tickets` for `bug_tracker_uri`".freeze
  s.email = ["halostatue@gmail.com".freeze]
  s.extra_rdoc_files = ["CHANGELOG.md".freeze, "Manifest.txt".freeze, "README.md".freeze]
  s.files = ["CHANGELOG.md".freeze, "Manifest.txt".freeze, "README.md".freeze]
  s.licenses = ["MIT".freeze]
  s.rdoc_options = ["--main".freeze, "README.md".freeze]
  s.rubygems_version = "3.5.23".freeze
  s.summary = "Hoe::Halostatue is a [Hoe][hoe] meta-plugin that ensures that the following plugins are installed and enabled for your project:  - [`hoe-doofus`][hoe-doofus] - [`hoe-gemspec2`][hoe-gemspec2] - [`hoe-git2`][hoe-git2] - [`hoe-markdown`][hoe-markdown] - [`hoe-rubygems`][hoe-rubygems]  It also provides an improved implementation for `Hoe#parse_urls` that works better with a Markdown README".freeze

  s.installed_by_version = "3.6.2".freeze

  s.specification_version = 4

  s.add_runtime_dependency(%q<hoe>.freeze, [">= 3.0".freeze, "< 5".freeze])
  s.add_runtime_dependency(%q<hoe-doofus>.freeze, ["~> 1.0".freeze])
  s.add_runtime_dependency(%q<hoe-gemspec2>.freeze, ["~> 1.1".freeze])
  s.add_runtime_dependency(%q<hoe-git2>.freeze, ["~> 1.8".freeze])
  s.add_runtime_dependency(%q<hoe-markdown>.freeze, ["~> 1.6".freeze])
  s.add_runtime_dependency(%q<hoe-rubygems>.freeze, ["~> 1.0".freeze])
  s.add_development_dependency(%q<standard>.freeze, ["~> 1.0".freeze])
  s.add_development_dependency(%q<rdoc>.freeze, [">= 4.0".freeze, "< 7".freeze])
end
