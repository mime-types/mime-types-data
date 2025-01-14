require_relative "lib/hoe/markdown/version"

Gem::Specification.new do |spec|
  spec.name = "hoe-markdown"
  spec.version = Hoe::Markdown::VERSION
  spec.authors = ["Mike Dalessio"]
  spec.email = ["mike.dalessio@gmail.com"]

  spec.summary = %q{Hoe plugin with helpers for markdown documentation files.}
  spec.description = %q{Hoe plugin with markdown helpers, for example to hyperlink github issues and github usernames in markdown files.}
  spec.homepage = "https://github.com/flavorjones/hoe-markdown"
  spec.license = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path("..", __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency("rake", ">0")
end
