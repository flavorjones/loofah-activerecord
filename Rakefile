require 'rubygems'
gem 'hoe', '>= 2.3.0'
require 'hoe'

require 'concourse'

Hoe.plugin :git
Hoe.plugin :bundler
Hoe.plugin :gemspec

Hoe.spec "loofah-activerecord" do
  developer "Mike Dalessio", "mike.dalessio@gmail.com"

  self.history_file     = "CHANGELOG.md"
  self.readme_file      = "README.md"
  self.license          "MIT"

  extra_deps << ["loofah", ">= 1.0.0"]

  extra_dev_deps << ["minitest", "~>2.2"]
  extra_dev_deps << ["rr", "~>1.0"]
  extra_dev_deps << ["acts_as_fu", ">=0.0.5"]
  extra_dev_deps << ["bundler", ">=1.2.0"]
  extra_dev_deps << ["hoe-git", ">=0"]
  extra_dev_deps << ["hoe-bundler", ">=0"]
  extra_dev_deps << ["hoe-gemspec", ">=0"]
  extra_dev_deps << ["unindent", ">=0"]
  extra_dev_deps << ["concourse", ">=0"]
end

require_relative "test/rails_test_helper"

namespace :test do
  namespace :rails do
    Loofah::RailsTests::VERSIONS.each do |version|
      Loofah::RailsTests::FLAVORS.each do |flavor|
        name = "#{version}-#{flavor}"
        desc "test rails #{name}"
        task "#{name}" => "gem:spec" do
          Loofah::RailsTests.test version, flavor
        end
      end
    end
  end

  desc "run all rails tests"
  task :rails => "gem:spec" do
    Loofah::RailsTests::VERSIONS.each do |version|
      Loofah::RailsTests::FLAVORS.each do |flavor|
        name = "#{version}-#{flavor}"
        Rake::Task["test:rails:#{name}"].invoke
      end
    end
  end
end

Concourse.new("loofah-activerecord", directory: "concourse").create_tasks!
