class Hoe
  module Markdown
    class Standalone
      include Hoe::Markdown

      attr_reader :spec

      def initialize gem_name
        @spec = Bundler.load_gemspec("#{gem_name}.gemspec")
      end
    end
  end
end
