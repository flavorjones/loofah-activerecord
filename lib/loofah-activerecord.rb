$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__))) unless $LOAD_PATH.include?(File.expand_path(File.dirname(__FILE__)))

require 'loofah'

module Loofah::ActiveRecord
  VERSION = "1.0.0"
end

if defined?(Rails) && Rails::VERSION::MAJOR == 3
  require 'loofah-activerecord/railtie'
elsif defined? Rails.configuration and Rails.configuration.frameworks.include?([:active_record]) # >= 2.1
  Rails.configuration.after_initialize do
    require 'loofah-activerecord/active_record'
    require 'loofah-activerecord/xss_foliate'
  end
elsif defined? ActiveRecord::Base # <= 2.0
  require 'loofah-activerecord/active_record'
  require 'loofah-activerecord/xss_foliate'
end
