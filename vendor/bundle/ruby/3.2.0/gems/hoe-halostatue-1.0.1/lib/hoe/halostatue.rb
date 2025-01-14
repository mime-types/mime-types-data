# frozen_string_literal: true

Hoe.plugin :doofus
Hoe.plugin :gemspec2
Hoe.plugin :git2
Hoe.plugin :markdown
Hoe.plugin :rubygems

# Hoe::Halostatue is a Hoe meta-plugin that ensures that the following
# plugins are installed and enabled for your project:
#
# - hoe-doofus (release checklist)
# - hoe-gemspec2 (gemspec generation)
# - hoe-git2 (git manifest and tag generation)
# - hoe-markdown (default to Markdown files and auto-linkification)
#
# It also provides an improved implementation for Hoe#parse_urls that
# works better with a Markdown README. It allows either +*+ or +-+ as
# list leaders for the README. It also allows the URLs to be blank.
# Double colons are still required for pattern matching.
#
# In addition to the four letter aliases in Hoe::URLS_TO_META_MAP
# (+bugs+, +clog+, +doco+, +docs+, +home+, +code+, +wiki+, and +mail+),
# this adds:
#
# - +changelog+, +changes+, and +history+ as aliases for +changelog_uri+
# - +documentation+ for +documentation_uri+
# - +issues+ and +tickets+ for +bug_tracker_uri+

module Hoe::Halostatue
  VERSION = "1.0.1"

  def initialize_halostatue # :nodoc:
    Hoe::URLS_TO_META_MAP.update Hoe::Halostatue::ParseUrls::URLS_TO_META_MAP

    Hoe.prepend Hoe::Halostatue::ParseUrls
  end

  def define_halostatue_tasks # :nodoc:
  end

  module ParseUrls
    URLS_TO_META_MAP = {
      "changelog" => "changelog_uri",
      "changes" => "changelog_uri",
      "documentation" => "documentation_uri",
      "history" => "changelog_uri",
      "issues" => "bug_tracker_uri",
      "tickets" => "bug_tracker_uri"
    }

    def parse_urls text
      lines = text.gsub(/^[-*] /, "").delete("<>").split("\n").grep(/\S+/)

      return {} if lines.empty?

      if /::/.match?(lines.first)
        Hash[lines.map { |line| line.split(/\s*::\s*/) }]
      else
        {}
      end
    end
  end
end
