class Post < ActiveRecord::Base
  html_fragment :body, :scrub => :strip
  attr_accessible :title, :body if Rails::VERSION::MAJOR == 3
end
