class Hoe
  module Markdown
    module Util
      GITHUB_ISSUE_MENTION_REGEX = %r{
        # not immediately preceded by a word character
        (?<!\w)

        # issue number, like '#1234'
        \#([[:digit:]]+)

        # not already in a markdown hyperlink
        (?!\][\(\[])

        # don't truncate the issue number to meet the previous negative lookahead
        (?![[[:digit:]]])
      }x

      # see https://github.com/shinnn/github-username-regex
      GITHUB_USER_REGEX = %r{
        # not obviously part of an email address
        (?<![[:alnum:]])

        # username, like "@flavorjones"
        @([[:alnum:]](?:[[:alnum:]]|-(?=[[:alnum:]])){0,38})

        # not already in a markdown hyperlink
        (?!\][\(\[])

        # don't truncate the username to meet the previous negative lookahead
        (?![[[:alnum:]]-])
      }x

      def self.linkify_github_issues(markdown, issues_uri)
        if issues_uri.nil? || issues_uri.empty?
          raise "#{__FILE__}:#{__method__}: URI for bugs cannot be empty\n"
        end

        issue_uri_regex = %r{
          # not already in a markdown hyperlink
          (?<!\]\()

          #{issues_uri}/([[:digit:]]+)

          # don't truncate the issue number to meet the previous negative lookahead
          (?![[[:digit:]]])
        }x

        pull_uri = issues_uri.gsub("issues", "pull")
        pull_uri_regex = %r{
          # not already in a markdown hyperlink
          (?<!\]\()

          #{pull_uri}/([[:digit:]]+)

          # don't truncate the issue number to meet the previous negative lookahead
          (?![[[:digit:]]])
        }x

        markdown
          .gsub(GITHUB_ISSUE_MENTION_REGEX) {
            __replace_with_link(Regexp.last_match, "[#%<id>s](#{issues_uri}/%<id>s)")
          }
          .gsub(issue_uri_regex) {
            __replace_with_link(Regexp.last_match, "[#%<id>s](#{issues_uri}/%<id>s)")
          }
          .gsub(pull_uri_regex) {
            __replace_with_link(Regexp.last_match, "[#%<id>s](#{pull_uri}/%<id>s)")
          }
      end

      def self.linkify_github_usernames(markdown)
        markdown.gsub(GITHUB_USER_REGEX) {
          __replace_with_link(Regexp.last_match, "[@%<id>s](https://github.com/%<id>s)")
        }
      end

      def self.__replace_with_link(match, link)
        skip =
          (match.pre_match.end_with?("\n[") && match.post_match =~ /\A\]:\s+.+\n/) ||
          (match.pre_match =~ /\]\[[^\]]*\z/ && match.post_match =~ /\A[^\]]*\]/)

        if skip
          match[0]
        else
          link % {id: match[1]}
        end
      end
    end
  end
end
