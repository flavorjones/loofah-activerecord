require 'rubygems'
gem 'hoe', '>= 2.3.0'
require 'hoe'

Hoe.plugin :git
Hoe.plugin :bundler
Hoe.plugin :gemspec

Hoe.spec "loofah-activerecord" do
  developer "Mike Dalessio", "mike.dalessio@gmail.com"

  self.extra_rdoc_files = FileList["*.rdoc"]
  self.history_file     = "CHANGELOG.rdoc"
  self.readme_file      = "README.rdoc"

  extra_deps << ["loofah", ">= 1.0.0"]

  extra_dev_deps << ["minitest", "~>2.2"]
  extra_dev_deps << ["rr", "~>1.0"]
  extra_dev_deps << ["acts_as_fu", ">=0.0.5"]
  extra_dev_deps << ["bundler", "~>1.0"]
  extra_dev_deps << ["hoe-git", ">=0"]
  extra_dev_deps << ["hoe-bundler", ">=0"]
  extra_dev_deps << ["hoe-gemspec", ">=0"]
end

load "rails_test/Rakefile"

task "test:rails" => "gem:spec"

task :redocs => :fix_css
task :docs => :fix_css
task :fix_css do
  better_css = <<-EOT
    .method-description pre {
      margin                    : 1em 0 ;
    }

    .method-description ul {
      padding                   : .5em 0 .5em 2em ;
    }

    .method-description p {
      margin-top                : .5em ;
    }

    h2 + ul {
      margin-top                : 1em;
    }
  EOT
  puts "* fixing css"
  File.open("doc/rdoc.css", "a") { |f| f.write better_css }
end
