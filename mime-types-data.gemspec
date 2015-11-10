# -*- encoding: utf-8 -*-
# stub: mime-types-data 2.6.2 ruby lib

Gem::Specification.new do |s|
  s.name = "mime-types-data"
  s.version = "2.6.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Austin Ziegler"]
  s.date = "2015-11-10"
  s.description = "The mime-types library provides a library and registry for information about\nMIME content type definitions. It can be used to determine defined filename\nextensions for MIME types, or to use filename extensions to look up the likely\nMIME type definitions.\n\nMIME content types are used in MIME-compliant communications, as in e-mail or\nHTTP traffic, to indicate the type of content which is transmitted. The\nmime-types library provides the ability for detailed information about MIME\nentities (provided as an enumerable collection of MIME::Type objects) to be\ndetermined and used. There are many types defined by RFCs and vendors, so the\nlist is long but by definition incomplete; don't hesitate to add additional\ntype definitions. MIME type definitions found in mime-types are from RFCs, W3C\nrecommendations, the {IANA Media Types\nregistry}[https://www.iana.org/assignments/media-types/media-types.xhtml], and\nuser contributions. It conforms to RFCs 2045 and 2231.\n\nThis is release 2.6 with two new experimental features. The first new feature\nis a new default registry storage format that greatly reduces the initial\nmemory use of the mime-types library. This feature is enabled by requiring\n+mime/types/columnar+ instead of +mime/types+ with a small performance cost and\nno change in *total* memory use if certain methods are called (see {Columnar\nStore}[#label-Columnar+Store]). The second new feature is a logger interface\nthat conforms to the expectations of an ActiveSupport::Logger so that warnings\ncan be written to an application's log rather than the default location for\n+warn+. This interface may be used for other logging purposes in the future.\n\nmime-types 2.6 is the last planned version of mime-types 2.x, so deprecation\nwarnings are no longer cached but provided every time the method is called.\nmime-types 2.6 supports Ruby 1.9.2 or later."
  s.email = ["halostatue@gmail.com"]
  s.extra_rdoc_files = ["Manifest.txt", "docs/COPYING.txt", "docs/artistic.txt"]
  s.files = [".gitignore", ".hoerc", "Manifest.txt", "Rakefile", "data/mime-types.json", "data/mime.content_type.column", "data/mime.docs.column", "data/mime.encoding.column", "data/mime.friendly.column", "data/mime.obsolete.column", "data/mime.references.column", "data/mime.registered.column", "data/mime.signature.column", "data/mime.system.column", "data/mime.use_instead.column", "data/mime.xrefs.column", "docs/COPYING.txt", "docs/artistic.txt", "lib/mime-types.rb", "lib/mime/type.rb", "lib/mime/type/columnar.rb", "lib/mime/types.rb", "test/bad-fixtures/malformed", "test/fixture/json.json", "test/fixture/old-data", "test/fixture/yaml.yaml", "test/minitest_helper.rb", "test/test_mime_type.rb", "test/test_mime_types.rb", "test/test_mime_types_cache.rb", "test/test_mime_types_class.rb", "test/test_mime_types_lazy.rb", "test/test_mime_types_loader.rb"]
  s.homepage = "https://github.com/mime-types/ruby-mime-types/"
  s.licenses = ["MIT"]
  s.rdoc_options = ["--main", "README.md"]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0")
  s.rubygems_version = "2.4.8"
  s.summary = "The mime-types library provides a library and registry for information about MIME content type definitions"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rdoc>, ["~> 4.0"])
      s.add_development_dependency(%q<nokogiri>, [">= 0"])
      s.add_development_dependency(%q<hoe-doofus>, ["~> 1.0"])
      s.add_development_dependency(%q<hoe-gemspec2>, ["~> 1.1"])
      s.add_development_dependency(%q<hoe-git>, ["~> 1.6"])
      s.add_development_dependency(%q<hoe-rubygems>, ["~> 1.0"])
      s.add_development_dependency(%q<rake>, ["~> 10.0"])
      s.add_development_dependency(%q<hoe>, ["~> 3.14"])
    else
      s.add_dependency(%q<rdoc>, ["~> 4.0"])
      s.add_dependency(%q<nokogiri>, [">= 0"])
      s.add_dependency(%q<hoe-doofus>, ["~> 1.0"])
      s.add_dependency(%q<hoe-gemspec2>, ["~> 1.1"])
      s.add_dependency(%q<hoe-git>, ["~> 1.6"])
      s.add_dependency(%q<hoe-rubygems>, ["~> 1.0"])
      s.add_dependency(%q<rake>, ["~> 10.0"])
      s.add_dependency(%q<hoe>, ["~> 3.14"])
    end
  else
    s.add_dependency(%q<rdoc>, ["~> 4.0"])
    s.add_dependency(%q<nokogiri>, [">= 0"])
    s.add_dependency(%q<hoe-doofus>, ["~> 1.0"])
    s.add_dependency(%q<hoe-gemspec2>, ["~> 1.1"])
    s.add_dependency(%q<hoe-git>, ["~> 1.6"])
    s.add_dependency(%q<hoe-rubygems>, ["~> 1.0"])
    s.add_dependency(%q<rake>, ["~> 10.0"])
    s.add_dependency(%q<hoe>, ["~> 3.14"])
  end
end
