require 'loofah'

module Loofah::ActiveRecord
  VERSION = "2.0.0"
end

if defined?(Rails) && defined?(Rails::Railtie)
  require_relative 'loofah/activerecord/railtie'
elsif defined? Rails.configuration and Rails.configuration.frameworks.include?([:active_record]) # >= 2.1
  Rails.configuration.after_initialize do
    require_relative 'loofah/activerecord/active_record'
    require_relative 'loofah/activerecord/xss_foliate'
  end
elsif defined? ActiveRecord::Base # <= 2.0
  require_relative 'loofah/activerecord/active_record'
  require_relative 'loofah/activerecord/xss_foliate'
end
