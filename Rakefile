require 'rubygems'
gem 'hoe', '>= 2.3.0'
require 'hoe'

Hoe.plugin :git
Hoe.plugin :bundler

Hoe.spec "loofah-activerecord" do
  developer "Mike Dalessio", "mike.dalessio@gmail.com"

  self.extra_rdoc_files = FileList["*.rdoc"]
  self.history_file     = "CHANGELOG.rdoc"
  self.readme_file      = "README.rdoc"

  extra_deps << ["loofah", ">= 1.0.0.beta.1"]
  extra_dev_deps << ["mocha", ">=0.9"]
  extra_dev_deps << ["shoulda", ">=2.10"]
  extra_dev_deps << ["acts_as_fu", ">=0.0.5"]
  extra_dev_deps << ["sqlite3-ruby", ">=1.2"] # acts_as_fu dependency
end

load "rails_test/Rakefile"

task :gemspec do
  system %q(rake debug_gem | grep -v "^\(in " > loofah-activerecord.gemspec)
end
task "test:rails" => :gemspec

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

    #main ul, div#documentation ul {
      list-style-type           : disc ! IMPORTANT ;
      list-style-position       : inside ! IMPORTANT ;
    }

    h2 + ul {
      margin-top                : 1em;
    }
  EOT
  puts "* fixing css"
  File.open("doc/rdoc.css", "a") { |f| f.write better_css }
end
