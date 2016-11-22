# -*- encoding: utf-8 -*-
# stub: loofah-activerecord 1.2.0.20161122091220 ruby lib

Gem::Specification.new do |s|
  s.name = "loofah-activerecord"
  s.version = "1.2.0.20161122091220"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Mike Dalessio"]
  s.date = "2016-11-22"
  s.description = "+loofah-activerecord+ extends +loofah+'s HTML sanitization into Rails\nActiveRecord models.\n\nSee more about +loofah+ at: http://github.com/flavorjones/loofah"
  s.email = ["mike.dalessio@gmail.com"]
  s.extra_rdoc_files = ["CHANGELOG.rdoc", "MIT-LICENSE.txt", "Manifest.txt", "README.rdoc", "CHANGELOG.rdoc", "README.rdoc"]
  s.files = [".gemtest", "CHANGELOG.rdoc", "Gemfile", "MIT-LICENSE.txt", "Manifest.txt", "README.rdoc", "Rakefile", "lib/loofah-activerecord.rb", "lib/loofah/activerecord/active_record.rb", "lib/loofah/activerecord/railtie.rb", "lib/loofah/activerecord/xss_foliate.rb", "rails_test/Rakefile", "rails_test/common/active_record/app/models/post.rb", "rails_test/common/active_record/test/unit/posts_test.rb", "rails_test/common/all/config/database.yml", "rails_test/common/all/db/migrate/1_create_posts.rb", "rails_test/common/xss_foliate/app/models/post.rb", "rails_test/common/xss_foliate/test/unit/posts_test.rb", "rails_test/generate_test_directory", "test/helper.rb", "test/unit/test_active_record.rb", "test/unit/test_xss_foliate.rb"]
  s.homepage = "http://github.com/flavorjones/loofah-activerecord"
  s.licenses = ["MIT"]
  s.rdoc_options = ["--main", "README.rdoc"]
  s.rubygems_version = "2.5.1"
  s.summary = "+loofah-activerecord+ extends +loofah+'s HTML sanitization into Rails ActiveRecord models"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<loofah>, [">= 1.0.0"])
      s.add_development_dependency(%q<minitest>, ["~> 2.2"])
      s.add_development_dependency(%q<rr>, ["~> 1.0"])
      s.add_development_dependency(%q<acts_as_fu>, [">= 0.0.5"])
      s.add_development_dependency(%q<bundler>, [">= 1.2.0"])
      s.add_development_dependency(%q<hoe-git>, [">= 0"])
      s.add_development_dependency(%q<hoe-bundler>, [">= 0"])
      s.add_development_dependency(%q<hoe-gemspec>, [">= 0"])
      s.add_development_dependency(%q<unindent>, [">= 0"])
      s.add_development_dependency(%q<rdoc>, ["~> 4.0"])
      s.add_development_dependency(%q<hoe>, ["~> 3.15"])
    else
      s.add_dependency(%q<loofah>, [">= 1.0.0"])
      s.add_dependency(%q<minitest>, ["~> 2.2"])
      s.add_dependency(%q<rr>, ["~> 1.0"])
      s.add_dependency(%q<acts_as_fu>, [">= 0.0.5"])
      s.add_dependency(%q<bundler>, [">= 1.2.0"])
      s.add_dependency(%q<hoe-git>, [">= 0"])
      s.add_dependency(%q<hoe-bundler>, [">= 0"])
      s.add_dependency(%q<hoe-gemspec>, [">= 0"])
      s.add_dependency(%q<unindent>, [">= 0"])
      s.add_dependency(%q<rdoc>, ["~> 4.0"])
      s.add_dependency(%q<hoe>, ["~> 3.15"])
    end
  else
    s.add_dependency(%q<loofah>, [">= 1.0.0"])
    s.add_dependency(%q<minitest>, ["~> 2.2"])
    s.add_dependency(%q<rr>, ["~> 1.0"])
    s.add_dependency(%q<acts_as_fu>, [">= 0.0.5"])
    s.add_dependency(%q<bundler>, [">= 1.2.0"])
    s.add_dependency(%q<hoe-git>, [">= 0"])
    s.add_dependency(%q<hoe-bundler>, [">= 0"])
    s.add_dependency(%q<hoe-gemspec>, [">= 0"])
    s.add_dependency(%q<unindent>, [">= 0"])
    s.add_dependency(%q<rdoc>, ["~> 4.0"])
    s.add_dependency(%q<hoe>, ["~> 3.15"])
  end
end
