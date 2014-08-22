require 'rubygems'
require 'rr'
require 'minitest/unit'
require 'minitest/spec'
require 'minitest/autorun'
require 'acts_as_fu'

require File.expand_path(File.join(File.dirname(__FILE__), "..", "lib", "loofah-activerecord"))

puts "=> testing with Nokogiri #{Nokogiri::VERSION_INFO.inspect}"
puts "=> testing with Loofah #{Loofah::VERSION}"

class Loofah::ActiveRecord::TestCase < MiniTest::Spec
  class << self
    alias_method :context, :describe
  end
end
