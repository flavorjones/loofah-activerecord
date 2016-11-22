class Post < ActiveRecord::Base
  attr_accessible :title, :body if Rails::VERSION::MAJOR == 3
end
