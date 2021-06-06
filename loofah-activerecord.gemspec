require_relative "lib/loofah/activerecord/version"

Gem::Specification.new do |spec|
  spec.name = "loofah-activerecord"
  spec.version = Loofah::ActiveRecord::VERSION

  spec.author = "Mike Dalessio"
  spec.email = "mike.dalessio@gmail.com"

  spec.summary = "`loofah-activerecord` extends `loofah`'s HTML sanitization into Rails ActiveRecord models"
  spec.description = "`loofah-activerecord` extends `loofah`'s HTML sanitization into Rails\nActiveRecord models.\n\nSee more about `loofah` at: http://github.com/flavorjones/loofah"

  spec.homepage = "http://github.com/flavorjones/loofah-activerecord"
  spec.license = "MIT"

  spec.metadata = {
    "homepage_uri" => spec.homepage,
    "source_code_uri" => spec.homepage,
    "bug_tracker_uri" => "#{spec.homepage}/issues",
    "changelog_uri" => "#{spec.homepage}/blob/main/CHANGELOG.md",
    "documentation_uri" => "https://www.rubydoc.info/gems/loofah-activerecord/",
  }

  spec.require_paths = ["lib"]
  spec.files = Dir["Gemfile"] + Dir["Rakefile"] + Dir["*.rdoc"] + Dir["*.txt"] + Dir["lib/**/*"]
  spec.extra_rdoc_files = ["CHANGELOG.rdoc", "MIT-LICENSE.txt", "Manifest.txt", "README.rdoc"]
  spec.rdoc_options = ["--main", "README.md"]

  spec.add_runtime_dependency("loofah", [">= 1.0.0"])

  spec.add_development_dependency("bundler", [">= 1.2.0"])
  spec.add_development_dependency("minitest", ["~> 5.14.2"])
  spec.add_development_dependency("rake", ["~> 13.0"])
  spec.add_development_dependency("rr", ["~> 3.0"])
  spec.add_development_dependency("sqlite3", ["~> 1.4.2"])
  spec.add_development_dependency("unindent", [">= 0"])
  spec.add_development_dependency("with_model", ["~> 2.1.5"])
end
