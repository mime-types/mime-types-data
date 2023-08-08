module Hoe::Gemspec2
  VERSION = '1.3.0'

  def define_gemspec2_tasks
    gemspec = spec.name + '.gemspec'

    with_config do |config, _|
      unless config["exclude"] =~ '.gemspec'
        warn "WARNING You should add .gemspec to your .hoerc exclude list"
      end
    end

    file gemspec => %w[clobber Manifest.txt] + spec.files do
      open(gemspec, 'w') { |f|
        permitted_classes = %w[
          Symbol Time Date Gem::Dependency Gem::Platform Gem::Requirement
          Gem::Specification Gem::Version Gem::Version::Requirement
          YAML::Syck::DefaultKey Syck::DefaultKey
        ]
        permitted_symbols = %w[development runtime]
        spec2 = begin
                  YAML.safe_load(
                    YAML.dump(spec),
                    :permitted_classes => permitted_classes,
                    :permitted_symbols => permitted_symbols,
                    :aliases => true
                  )
                rescue
                  YAML.safe_load(
                    YAML.dump(spec), permitted_classes, permitted_symbols, true
                  )
                end

        unless @include_all
          [ :signing_key, :cert_chain ].each { |name|
            spec2.send("#{name}=".to_sym, spec2.default_value(name))
          }
        end
        f.write(spec2.to_ruby)
      }
    end

    desc "Regenerate #{gemspec} excluding signing keys"
    task :gemspec => gemspec

    namespace :gemspec do
      desc "Regenerate #{gemspec} with all keys"
      task :full do
        @include_all = true
        Rake::Task['gemspec'].invoke
      end
    end

    task :default => gemspec
  end
end
