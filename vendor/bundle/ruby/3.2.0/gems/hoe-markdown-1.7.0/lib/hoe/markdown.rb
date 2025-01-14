require "rake"

class Hoe
  module Markdown
    include ::Rake::DSL

    #
    #  Optional: used to specify which markdown files to linkify. [default: any markdown files found in `files`].
    #
    attr_accessor :markdown_linkify_files

    def default_markdown_linkify_files
      spec.files.grep(/\.md$/)
    end

    def initialize_markdown
      @markdown_linkify_files = nil

      if File.exist?("CHANGELOG.md")
        self.history_file = "CHANGELOG.md"
      end

      if File.exist?("README.md")
        self.readme_file = "README.md"
      end
    end

    def define_markdown_tasks(*additional_files)
      @markdown_linkify_files ||= default_markdown_linkify_files
      @markdown_linkify_files = @markdown_linkify_files.append(*additional_files).uniq
      return if markdown_linkify_files.empty?

      namespace_name = "markdown:linkify"
      linkify_tasks = []

      namespace namespace_name do
        markdown_linkify_files.each do |mdfile_path|
          mdfile_name = File.basename(mdfile_path)
          task_name = mdfile_name.downcase.split(".")[0..-2].join(".")

          desc "hyperlink github issues and usernames in #{mdfile_name}"
          task task_name do
            original_markdown = markdown = File.read(mdfile_path)

            markdown = Hoe::Markdown::Util.linkify_github_usernames(markdown)
            if spec.metadata["bug_tracker_uri"]
              markdown = Hoe::Markdown::Util.linkify_github_issues(markdown, spec.metadata["bug_tracker_uri"])
            else
              warn "Spec metadata URI for 'bugs' is missing, skipping linkification of issues and pull requests"
            end

            if markdown == original_markdown
              puts "markdown:linkify: no changes to #{mdfile_path}"
            else
              puts "markdown:linkify: updating #{mdfile_path}"
              File.open(mdfile_path, "w") { |f| f.write markdown }
            end
          end
          linkify_tasks << "#{namespace_name}:#{task_name}"
        end
      end

      desc "hyperlink github issues and usernames in markdown files"
      task namespace_name => linkify_tasks
    end
  end
end

require "hoe/markdown/version"
require "hoe/markdown/util"
require "hoe/markdown/standalone"
