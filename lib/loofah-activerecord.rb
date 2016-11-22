$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__))) unless $LOAD_PATH.include?(File.expand_path(File.dirname(__FILE__)))

require 'loofah'

module Loofah::ActiveRecord
  VERSION = "2.0.0"
end

if defined?(Rails) && defined?(Rails::Railtie)
  require 'loofah/activerecord/railtie'
elsif defined? Rails.configuration and Rails.configuration.frameworks.include?([:active_record]) # >= 2.1
  Rails.configuration.after_initialize do
    require 'loofah/activerecord/active_record'
    require 'loofah/activerecord/xss_foliate'
  end
elsif defined? ActiveRecord::Base # <= 2.0
  require 'loofah/activerecord/active_record'
  require 'loofah/activerecord/xss_foliate'
end
