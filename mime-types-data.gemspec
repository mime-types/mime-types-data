# -*- encoding: utf-8 -*-
# stub: mime-types-data 3.2024.0806 ruby lib

Gem::Specification.new do |s|
  s.name = "mime-types-data".freeze
  s.version = "3.2024.0806".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "rubygems_mfa_required" => "true" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Austin Ziegler".freeze]
  s.date = "2024-08-06"
  s.description = "mime-types-data provides a registry for information about MIME media type\ndefinitions. It can be used with the Ruby mime-types library or other software\nto determine defined filename extensions for MIME types, or to use filename\nextensions to look up the likely MIME type definitions.".freeze
  s.email = ["halostatue@gmail.com".freeze]
  s.extra_rdoc_files = ["Code-of-Conduct.md".freeze, "Contributing.md".freeze, "History.md".freeze, "Licence.md".freeze, "Manifest.txt".freeze, "README.md".freeze]
  s.files = ["Code-of-Conduct.md".freeze, "Contributing.md".freeze, "History.md".freeze, "Licence.md".freeze, "Manifest.txt".freeze, "README.md".freeze, "Rakefile".freeze, "data/content_type_mime.db".freeze, "data/ext_mime.db".freeze, "data/mime-types.json".freeze, "data/mime.content_type.column".freeze, "data/mime.docs.column".freeze, "data/mime.encoding.column".freeze, "data/mime.flags.column".freeze, "data/mime.friendly.column".freeze, "data/mime.pext.column".freeze, "data/mime.use_instead.column".freeze, "data/mime.xrefs.column".freeze, "lib/mime-types-data.rb".freeze, "lib/mime/types/data.rb".freeze, "types/application.yaml".freeze, "types/audio.yaml".freeze, "types/chemical.yaml".freeze, "types/conference.yaml".freeze, "types/drawing.yaml".freeze, "types/example.yaml".freeze, "types/font.yaml".freeze, "types/haptics.yaml".freeze, "types/image.yaml".freeze, "types/message.yaml".freeze, "types/model.yaml".freeze, "types/multipart.yaml".freeze, "types/text.yaml".freeze, "types/video.yaml".freeze, "types/world.yaml".freeze]
  s.homepage = "https://github.com/mime-types/mime-types-data/".freeze
  s.licenses = ["MIT".freeze]
  s.rdoc_options = ["--main".freeze, "README.md".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0".freeze)
  s.rubygems_version = "3.5.17".freeze
  s.summary = "mime-types-data provides a registry for information about MIME media type definitions".freeze

  s.specification_version = 4

  s.add_development_dependency(%q<hoe>.freeze, ["~> 4.0".freeze])
  s.add_development_dependency(%q<hoe-doofus>.freeze, ["~> 1.0".freeze])
  s.add_development_dependency(%q<hoe-gemspec2>.freeze, ["~> 1.1".freeze])
  s.add_development_dependency(%q<hoe-git2>.freeze, ["~> 1.7".freeze])
  s.add_development_dependency(%q<hoe-rubygems>.freeze, ["~> 1.0".freeze])
  s.add_development_dependency(%q<mime-types>.freeze, [">= 3.4.0".freeze, "< 4".freeze])
  s.add_development_dependency(%q<nokogiri>.freeze, ["~> 1.6".freeze])
  s.add_development_dependency(%q<rake>.freeze, [">= 10.0".freeze, "< 14".freeze])
  s.add_development_dependency(%q<standard>.freeze, ["~> 1.0".freeze])
  s.add_development_dependency(%q<rdoc>.freeze, [">= 4.0".freeze, "< 7".freeze])
end
