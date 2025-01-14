class Hoe #:nodoc:
  module Doofus

    # Duh.
    VERSION = "1.0.0"

    # An array of reminder questions that should be asked before a
    # release, in the form, "Did you... [question]?" You can see the
    # defaults by running <tt>rake doofus</tt>.

    attr_accessor :doofus_checklist

    def initialize_doofus #:nodoc:
      self.doofus_checklist = []

      doofus_checklist                <<
        "bump the version"            <<
        "check everything in"         <<
        "review the manifest"         <<
        "update the README and RDocs" <<
        "update the changelog"
    end

    def define_doofus_tasks #:nodoc:

      desc "Show a reminder for the steps I always forget."
      task :doofus do
        puts "\n### HEY! Doofus! Did you...\n\n"

        doofus_checklist.each do |question|
          question[0..0] = question[0..0].upcase
          question << "?" unless question[-2..-1] == "?"
          puts "  * #{question}"
        end

        puts
      end

      task :release_sanity do
        Rake::Task[:doofus].invoke
        puts "Hit return if you're sure, Ctrl-C if you forgot something."
        $stdin.gets
      end
    end
  end
end
