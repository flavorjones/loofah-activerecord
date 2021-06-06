require 'rails'
module Loofah::ActiveRecord
  class Railtie < Rails::Railtie
    initializer "loofah-activerecord.initialize" do |app|
      railtie_collection = if app.railties.respond_to?(:all) # Rails::VERSION::MAJOR == 3
                             app.railties.all
                           else # Rails::VERSION::MAJOR == 4
                             app.railties
                           end
      activerecord_railtie = railtie_collection.select {|railtie| railtie.class.to_s == "ActiveRecord::Railtie" }
      if activerecord_railtie
        require_relative 'active_record'
        require_relative 'xss_foliate'
      end
    end
  end
end
