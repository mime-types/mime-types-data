# frozen_string_literal: true

$LOAD_PATH.unshift "lib"

require "hoe"

Hoe.plugin :halostatue

Hoe.spec "hoe-halostatue" do
  developer "Austin Ziegler", "halostatue@gmail.com"

  self.extra_rdoc_files = FileList["*.rdoc"]

  license "MIT"

  extra_deps << ["hoe", ">= 3.0", "< 5"]
  extra_deps << ["hoe-doofus", "~> 1.0"]
  extra_deps << ["hoe-gemspec2", "~> 1.1"]
  extra_deps << ["hoe-git2", "~> 1.8"]
  extra_deps << ["hoe-markdown", "~> 1.6"]
  extra_deps << ["hoe-rubygems", "~> 1.0"]

  extra_dev_deps << ["standard", "~> 1.0"]
end
