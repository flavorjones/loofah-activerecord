require 'rubygems'

require "rake/testtask"
Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = Dir["test/**/*.rb"]
end

require_relative "test/rails_test_helper"

namespace :test do
  namespace :rails do
    Loofah::RailsTests::VERSIONS.each do |version|
      Loofah::RailsTests::FLAVORS.each do |flavor|
        name = "#{version}-#{flavor}"
        desc "test rails #{name}"
        task "#{name}" do
          Loofah::RailsTests.test version, flavor
        end
      end
    end
  end

  desc "run all rails tests"
  task :rails do
    Loofah::RailsTests::VERSIONS.each do |version|
      Loofah::RailsTests::FLAVORS.each do |flavor|
        name = "#{version}-#{flavor}"
        Rake::Task["test:rails:#{name}"].invoke
      end
    end
  end
end

desc "generate the github actions pipeline"
task "generate_pipeline" do
  require_relative "test/rails_test_helper"
  Loofah::RailsTests.generate_github_actions_pipeline("ci.yml")
end

require 'concourse'
Concourse.new("loofah-activerecord", directory: "concourse", fly_target: "ci", format: true).create_tasks!
