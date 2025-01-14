require "shellwords"

class Hoe # :nodoc:
  # This module is a Hoe plugin. You can set its attributes in your
  # Rakefile Hoe spec, like this:
  #
  #    Hoe.plugin :git
  #
  #    Hoe.spec "myproj" do
  #      self.git_release_tag_prefix  = "REL_"
  #      self.git_remotes            << "myremote"
  #    end
  #
  #
  # === Tasks
  #
  # git:changelog:: Print the current changelog.
  # git:manifest::  Update the manifest with Git's file list.
  # git:tag::       Create and push a tag.

  module Git2
    # Duh.
    VERSION = "1.8.0"

    # What do you want at the front of your release tags?
    # [default: <tt>"v"</tt>]

    attr_accessor :git_release_tag_prefix

    # Which remotes do you want to push tags, etc. to?
    # [default: <tt>%w(origin)</tt>]

    attr_accessor :git_remotes

    def initialize_git2 # :nodoc:
      self.git_release_tag_prefix = "v"
      self.git_remotes = %w[origin]
    end

    def define_git2_tasks # :nodoc:
      return unless __run_git("rev-parse", "--is-inside-work-tree") == "true"

      desc "Print the current changelog."
      task "git:changelog" do
        tag = ENV["FROM"] || git_tags.last
        range = [tag, "HEAD"].compact.join("..")
        now = Time.new.strftime("%Y-%m-%d")

        changes =
          __run_git("log", range, "--format=tformat:%B|||%aN|||%aE|||")
            .split("|||")
            .each_slice(3)
            .map do |msg, _author, _email|
            msg.split("\n").reject(&:empty?)
          end

        changes = changes.flatten

        next if changes.empty?

        $changes = Hash.new { |h, k| h[k] = [] } # standard:disable Style/GlobalVars

        codes = {
          "!" => :major,
          "+" => :minor,
          "*" => :minor,
          "-" => :bug,
          "?" => :unknown
        }

        codes_re = Regexp.escape codes.keys.join

        changes.each do |change|
          if change =~ /^\s*([#{codes_re}])\s*(.*)/
            code, line = codes[$1], $2
          else
            code, line = codes["?"], change.chomp
          end

          $changes[code] << line # standard:disable Style/GlobalVars
        end

        puts "=== #{ENV["VERSION"] || "NEXT"} / #{now}"
        puts
        changelog_section :major
        changelog_section :minor
        changelog_section :bug
        changelog_section :unknown
        puts
      end

      desc "Update the manifest with Git's file list. Use Hoe's excludes."
      task "git:manifest" do
        with_config do |config, _|
          files = __run_git("ls-files").split($/)
          files.reject! { |f| f =~ config["exclude"] }

          File.open "Manifest.txt", "w" do |f|
            f.puts files.sort.join("\n")
          end
        end
      end

      desc "Create and push a TAG (default #{git_release_tag_prefix}#{version})."
      task "git:tag" do
        tag = ENV["TAG"]
        ver = ENV["VERSION"] || version
        pre = ENV["PRERELEASE"] || ENV["PRE"]
        ver += ".#{pre}" if pre
        tag ||= "#{git_release_tag_prefix}#{ver}"

        git_tag_and_push tag
      end

      task "git:tags" do
        p git_tags
      end

      task :release_sanity do
        unless __run_git("status", "--porcelain").empty?
          abort "Won't release: Dirty index or untracked files present!"
        end
      end

      task release_to: "git:tag"
    end

    def __git(command, *params)
      "git #{command.shellescape} #{params.compact.shelljoin}"
    end

    def __run_git(command, *params)
      `#{__git(command, *params)}`.strip.chomp
    end

    def git_svn?
      File.exist?(File.join(__run_git("rev-parse", "--show-toplevel"), ".git/svn"))
    end

    def git_tag_and_push tag
      msg = "Tagging #{tag}."

      if git_svn?
        sh __git("svn", "tag", tag, "-m", msg)
      else
        flags =
          if __run_git("config", "--get", "user.signingkey").empty?
            nil
          else
            "-s"
          end

        sh __git("tag", flags, "-f", tag, "-m", msg)
        git_remotes.each { |remote| sh __git("push", "-f", remote, "tag", tag) }
      end
    end

    def git_tags
      if git_svn?
        source = __run_git("config", "svn-remote.svn.tags")

        unless source =~ %r{refs/remotes/(.*)/\*$}
          abort "Can't discover git-svn tag scheme from #{source}"
        end

        prefix = $1

        __run_git("branch", "-r")
          .split($/)
          .collect { |t| t.strip }
          .select { |t| t =~ %r{^#{prefix}/#{git_release_tag_prefix}} }
      else
        flags = %w[--date-order --simplify-by-decoration --pretty=format:%H]
        hashes = __run_git("log", *flags).split($/).reverse
        names = __run_git("name-rev", "--tags", *hashes).split($/)
        names = names.map { |s| s[/tags\/(v.+)/, 1] }.compact
        names = names.map { |s| s.sub(/\^0$/, "") }
        names.select { |t| t =~ %r{^#{git_release_tag_prefix}} }
      end
    end

    def changelog_section(code)
      name = {
        major: "major enhancement",
        minor: "minor enhancement",
        bug: "bug fix",
        unknown: "unknown"
      }[code]

      changes = $changes[code] # standard:disable Style/GlobalVars
      count = changes.size
      name += "s" if count > 1
      name.sub!(/fixs/, "fixes")

      return if count < 1

      puts "* #{count} #{name}:"
      puts
      changes.sort.each do |line|
        puts "  * #{line}"
      end
      puts
    end
  end
end
