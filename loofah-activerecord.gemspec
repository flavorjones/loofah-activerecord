# -*- encoding: utf-8 -*-
# stub: loofah-activerecord 1.1.0.20140822163132 ruby lib

Gem::Specification.new do |s|
  s.name = "loofah-activerecord"
  s.version = "1.1.0.20140822163132"

  s.require_paths = ["lib"]
  s.authors = ["Mike Dalessio"]
  s.description = "+loofah-activerecord+ extends +loofah+'s HTML sanitization into Rails\nActiveRecord models.\n\nSee more about +loofah+ at: http://github.com/flavorjones/loofah"
  s.email = ["mike.dalessio@gmail.com"]
  s.extra_rdoc_files = ["CHANGELOG.rdoc", "MIT-LICENSE.txt", "Manifest.txt", "README.rdoc", "CHANGELOG.rdoc", "README.rdoc"]
  s.files = [".gemtest", "CHANGELOG.rdoc", "Gemfile", "MIT-LICENSE.txt", "Manifest.txt", "README.rdoc", "Rakefile", "lib/loofah-activerecord.rb", "lib/loofah/activerecord/active_record.rb", "lib/loofah/activerecord/railtie.rb", "lib/loofah/activerecord/xss_foliate.rb", "rails_test/Rakefile", "rails_test/common/active_record/app/models/post.rb", "rails_test/common/active_record/test/unit/posts_test.rb", "rails_test/common/all/config/database.yml", "rails_test/common/all/db/migrate/1_create_posts.rb", "rails_test/common/xss_foliate/app/models/post.rb", "rails_test/common/xss_foliate/test/unit/posts_test.rb", "rails_test/generate_test_directory", "test/helper.rb", "test/unit/test_active_record.rb", "test/unit/test_xss_foliate.rb"]
  s.homepage = "http://github.com/flavorjones/loofah-activerecord"
  s.licenses = ["MIT"]
  s.rdoc_options = ["--main", "README.rdoc"]
  s.rubygems_version = "2.2.2"
  s.summary = "+loofah-activerecord+ extends +loofah+'s HTML sanitization into Rails ActiveRecord models"
  s.test_files = ["test/unit/test_xss_foliate.rb", "test/unit/test_active_record.rb"]

  s.add_runtime_dependency(%q<loofah>, [">= 1.0.0"])
  s.add_development_dependency(%q<rdoc>, ["~> 4.0"])
  s.add_development_dependency(%q<minitest>, ["~> 2.2"])
  s.add_development_dependency(%q<rr>, ["~> 1.0"])
  s.add_development_dependency(%q<acts_as_fu>, [">= 0.0.5"])
  s.add_development_dependency(%q<bundler>, [">= 1.2.0"])
  s.add_development_dependency(%q<hoe-git>, [">= 0"])
  s.add_development_dependency(%q<hoe-bundler>, [">= 0"])
  s.add_development_dependency(%q<hoe-gemspec>, [">= 0"])
  s.add_development_dependency(%q<unindent>, [">= 0"])
  s.add_development_dependency(%q<hoe>, ["~> 3.12"])
end
