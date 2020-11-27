require "unindent"
require "bundler"

module Loofah
  module RailsTests
    FLAVORS = %w[xss_foliate active_record]

    RAILS_TO_RUBY_VERSIONS = {
      "3.2" => "2.4",
      "4.2" => "2.6",
      "5.1" => "2.7",
      "5.2" => "2.7",
      "6.0" => "2.7",
      "6.1" => "2.7",
    }

    VERSIONS = %w[
      3.2.22
      4.2.11
      5.1.7
      5.2.4
      6.0.3
      6.1.0.rc1
    ].map { |v| Gem::Version.new(v) }

    TMPDIR = "tmp"
    ARTIFACTS_DIR = File.expand_path(File.join(File.dirname(__FILE__), "..", "rails_test_artifacts"))

    SKIP_WEBPACK_REQUIREMENT = Gem::Requirement.new("~> 6.0")

    def self.test version, flavor
      snowflakes = gem_versions_for(version)

      bundle_version_args = if snowflakes.key?("bundler")
                              bundler_version = Gem::Requirement.new(snowflakes["bundler"]).requirements.first.last
                              Rake.sh "gem install bundler -v #{bundler_version}"
                              "_#{bundler_version}_"
                            else
                              ""
                            end

      dir = generate_test_app version, flavor, TMPDIR

      loofah_ar_dir = File.expand_path(File.join(File.dirname(__FILE__), ".."))

      Dir.chdir dir do
        File.open("Gemfile", "w") do |gemfile|
          gemfile.write <<-GEM.unindent
            source "https://rubygems.org"

            gem "rails", "~> #{version}"
            gem "loofah"
            gem "loofah-activerecord", :path => "#{loofah_ar_dir}"
          GEM
          gemfile.puts 'gem "sqlite3"' unless snowflakes.key?("sqlite3")
          snowflakes.each { |name, versionspec| gemfile.puts %Q{gem "#{name}", "#{versionspec}"} }
        end

        ::Bundler.with_unbundled_env do
          Rake.sh "bundle #{bundle_version_args} install"

          FileUtils.mkdir_p "log"

          # hack for 5.2.0.rc1
          if File.exist? "config/storage.yml"
            File.open("config/storage.yml", "w") do |f|
              f.write %Q{test:\n service: Disk\n root: <%= Rails.root.join("tmp/storage") %>}
            end
          end

          ENV['BUNDLE_GEMFILE'] = "./Gemfile"
          ENV['RAILS_ENV'] = "test"
          Rake.sh "bundle #{bundle_version_args} exec rake db:create db:migrate test:units"
        end
      end
    end

    def self.gem_versions_for rails_version
      mm = rails_version.canonical_segments[0,2].join(".")
      YAML.load_file(File.join(ARTIFACTS_DIR, "gem-versions.yml"))[mm] || {}
    end

    def self.generate_test_app version, flavor, parent_directory
      Dir.mkdir parent_directory unless Dir.exist? parent_directory
      dir = "rails-#{version}-#{flavor}"

      Dir.chdir parent_directory do
        FileUtils.rm_rf dir

        ::Bundler.with_unbundled_env do
          if %x{gem list "^rails$" -v #{version} -i} =~ /false/
            Rake.sh "gem install rails -v #{version}"
          end

          rails_new_args = SKIP_WEBPACK_REQUIREMENT.satisfied_by?(version) ? "--skip-webpack-install" : ""

          Rake.sh "yes | rails _#{version}_ new #{rails_new_args} #{dir}"
          Rake.sh "rsync -a #{ARTIFACTS_DIR}/all/ #{dir}"
          Rake.sh "rsync -a #{ARTIFACTS_DIR}/#{flavor}/ #{dir}"
        end
      end
      
      File.join parent_directory, dir
    end
  end
end
