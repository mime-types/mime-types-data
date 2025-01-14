class Hoe # :nodoc:
  module RubyGems

    # Duh.
    VERSION = "1.0.0"

    def define_rubygems_tasks
      gemspec = "#{spec.name}.gemspec"
      deps    = IO.read("Manifest.txt").split

      file gemspec => deps do |t|
        File.open(t.name, "w") { |f| f.write spec.to_ruby }
      end

      desc "Update #{gemspec} if necessary."
      task "gem:spec" => gemspec

      desc "Install gem, with optional prefix."
      task "gem:install", [:prefix] do |t, args|
        spec.name = "#{args.prefix}-#{spec.name}" if args.prefix
        Rake::Task["install_gem"].invoke
      end
    end
  end
end
