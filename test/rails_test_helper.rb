require "unindent"

module Loofah
  module RailsTests
    FLAVORS = %w[xss_foliate active_record]

    VERSIONS = %w[
      3.2.22.5
      4.2.10
      5.1.4
      5.2.0.rc1
    ]

    TMPDIR = "tmp"
    ARTIFACTS_DIR = File.expand_path(File.join(File.dirname(__FILE__), "..", "rails_test_artifacts"))

    def self.test version, flavor
      dir = generate_test_app version, flavor, TMPDIR

      snowflakes = Array gem_versions_for(version)

      loofah_ar_dir = File.expand_path(File.join(File.dirname(__FILE__), ".."))

      Dir.chdir dir do
        File.open("Gemfile", "w") do |gemfile|
          gemfile.write <<-GEM.unindent
            source "https://rubygems.org"

            gem "rails", "=#{version}"
            gem "loofah"
            gem "loofah-activerecord", :path => "#{loofah_ar_dir}"
            gem "sqlite3"
          GEM
          snowflakes.each { |name, versionspec| gemfile.puts %Q{gem "#{name}", "#{versionspec}"} }
        end

        Bundler.with_clean_env do
          FileUtils.mkdir_p "log"

          # hack for 5.2.0.rc1
          if File.exist? "config/storage.yml"
            File.open("config/storage.yml", "w") do |f|
              f.write %Q{test:\n service: Disk\n root: <%= Rails.root.join("tmp/storage") %>}
            end
          end

          ENV['BUNDLE_GEMFILE'] = "./Gemfile"
          ENV['RAILS_ENV'] = "test"
          Rake.sh "bundle exec rake db:create db:migrate test:units"
        end
      end
    end

    def self.gem_versions_for rails_version
      mm = rails_version.split(".")[0,2].join(".")
      YAML.load_file(File.join(ARTIFACTS_DIR, "gem-versions.yml"))[mm]
    end

    def self.generate_test_app version, flavor, parent_directory
      Dir.mkdir parent_directory unless Dir.exist? parent_directory
      dir = "rails-#{version}-#{flavor}"

      Dir.chdir parent_directory do
        FileUtils.rm_rf dir

        Bundler.with_clean_env do
          if %x{gem list "^rails$" -v #{version} -i} =~ /false/
            Rake.sh "gem install rails -v #{version}"
          end

          Rake.sh "yes | rails _#{version}_ new #{dir}"
          Rake.sh "rsync -a #{ARTIFACTS_DIR}/all/ #{dir}"
          Rake.sh "rsync -a #{ARTIFACTS_DIR}/#{flavor}/ #{dir}"
        end
      end
      
      File.join parent_directory, dir
    end
  end
end
