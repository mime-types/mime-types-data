# frozen_string_literal: true

$LOAD_PATH.unshift "lib"

require "rubygems"
require "hoe"

Hoe.plugin :doofus
Hoe.plugin :gemspec2
Hoe.plugin :git2

Hoe.spec "hoe-git2" do
  developer "John Barnette", "jbarnette@rubyforge.org"
  developer "Austin Ziegler", "halostatue@gmail.com"

  self.extra_rdoc_files = FileList["*.rdoc"]
  self.history_file = "CHANGELOG.md"
  self.readme_file = "README.rdoc"

  license "MIT"

  extra_dev_deps << ["hoe", ">= 3.0", "< 5"]

  extra_dev_deps << ["hoe-doofus", "~> 1.0"]
  extra_dev_deps << ["hoe-gemspec2", "~> 1.1"]
  extra_dev_deps << ["standard", "~> 1.0"]
end
