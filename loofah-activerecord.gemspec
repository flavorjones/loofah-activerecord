# -*- encoding: utf-8 -*-
# stub: loofah-activerecord 2.0.0.20201126111106 ruby lib

Gem::Specification.new do |s|
  s.name = "loofah-activerecord".freeze
  s.version = "2.0.0.20201126111106"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "homepage_uri" => "http://github.com/flavorjones/loofah-activerecord" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Mike Dalessio".freeze]
  s.date = "2020-11-26"
  s.description = "`loofah-activerecord` extends `loofah`'s HTML sanitization into Rails\nActiveRecord models.\n\nSee more about `loofah` at: http://github.com/flavorjones/loofah".freeze
  s.email = ["mike.dalessio@gmail.com".freeze]
  s.extra_rdoc_files = ["CHANGELOG.rdoc".freeze, "MIT-LICENSE.txt".freeze, "Manifest.txt".freeze, "README.rdoc".freeze]
  s.files = [".gemtest".freeze, "CHANGELOG.rdoc".freeze, "Gemfile".freeze, "MIT-LICENSE.txt".freeze, "Manifest.txt".freeze, "README.rdoc".freeze, "Rakefile".freeze, "lib/loofah-activerecord.rb".freeze, "lib/loofah/activerecord/active_record.rb".freeze, "lib/loofah/activerecord/railtie.rb".freeze, "lib/loofah/activerecord/xss_foliate.rb".freeze, "rails_test/Rakefile".freeze, "rails_test/common/active_record/app/models/post.rb".freeze, "rails_test/common/active_record/test/unit/posts_test.rb".freeze, "rails_test/common/all/config/database.yml".freeze, "rails_test/common/all/db/migrate/1_create_posts.rb".freeze, "rails_test/common/xss_foliate/app/models/post.rb".freeze, "rails_test/common/xss_foliate/test/unit/posts_test.rb".freeze, "rails_test/generate_test_directory".freeze, "test/helper.rb".freeze, "test/unit/test_active_record.rb".freeze, "test/unit/test_xss_foliate.rb".freeze]
  s.homepage = "http://github.com/flavorjones/loofah-activerecord".freeze
  s.licenses = ["MIT".freeze]
  s.rdoc_options = ["--main".freeze, "README.md".freeze]
  s.rubygems_version = "3.0.8".freeze
  s.summary = "`loofah-activerecord` extends `loofah`'s HTML sanitization into Rails ActiveRecord models".freeze

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<loofah>.freeze, [">= 1.0.0"])
      s.add_development_dependency(%q<bundler>.freeze, [">= 1.2.0"])
      s.add_development_dependency(%q<concourse>.freeze, [">= 0"])
      s.add_development_dependency(%q<hoe-bundler>.freeze, [">= 0"])
      s.add_development_dependency(%q<hoe-gemspec>.freeze, [">= 0"])
      s.add_development_dependency(%q<hoe-git>.freeze, [">= 0"])
      s.add_development_dependency(%q<minitest>.freeze, ["~> 5.14.2"])
      s.add_development_dependency(%q<rr>.freeze, ["~> 1.0"])
      s.add_development_dependency(%q<sqlite3>.freeze, ["~> 1.4.2"])
      s.add_development_dependency(%q<unindent>.freeze, [">= 0"])
      s.add_development_dependency(%q<with_model>.freeze, ["~> 2.1.5"])
      s.add_development_dependency(%q<rdoc>.freeze, [">= 4.0", "< 7"])
      s.add_development_dependency(%q<hoe>.freeze, ["~> 3.22"])
    else
      s.add_dependency(%q<loofah>.freeze, [">= 1.0.0"])
      s.add_dependency(%q<bundler>.freeze, [">= 1.2.0"])
      s.add_dependency(%q<concourse>.freeze, [">= 0"])
      s.add_dependency(%q<hoe-bundler>.freeze, [">= 0"])
      s.add_dependency(%q<hoe-gemspec>.freeze, [">= 0"])
      s.add_dependency(%q<hoe-git>.freeze, [">= 0"])
      s.add_dependency(%q<minitest>.freeze, ["~> 5.14.2"])
      s.add_dependency(%q<rr>.freeze, ["~> 1.0"])
      s.add_dependency(%q<sqlite3>.freeze, ["~> 1.4.2"])
      s.add_dependency(%q<unindent>.freeze, [">= 0"])
      s.add_dependency(%q<with_model>.freeze, ["~> 2.1.5"])
      s.add_dependency(%q<rdoc>.freeze, [">= 4.0", "< 7"])
      s.add_dependency(%q<hoe>.freeze, ["~> 3.22"])
    end
  else
    s.add_dependency(%q<loofah>.freeze, [">= 1.0.0"])
    s.add_dependency(%q<bundler>.freeze, [">= 1.2.0"])
    s.add_dependency(%q<concourse>.freeze, [">= 0"])
    s.add_dependency(%q<hoe-bundler>.freeze, [">= 0"])
    s.add_dependency(%q<hoe-gemspec>.freeze, [">= 0"])
    s.add_dependency(%q<hoe-git>.freeze, [">= 0"])
    s.add_dependency(%q<minitest>.freeze, ["~> 5.14.2"])
    s.add_dependency(%q<rr>.freeze, ["~> 1.0"])
    s.add_dependency(%q<sqlite3>.freeze, ["~> 1.4.2"])
    s.add_dependency(%q<unindent>.freeze, [">= 0"])
    s.add_dependency(%q<with_model>.freeze, ["~> 2.1.5"])
    s.add_dependency(%q<rdoc>.freeze, [">= 4.0", "< 7"])
    s.add_dependency(%q<hoe>.freeze, ["~> 3.22"])
  end
end
