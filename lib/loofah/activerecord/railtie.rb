require 'rails'
module Loofah::ActiveRecord
  class Railtie < Rails::Railtie
    initializer "loofah-activerecord.initialize" do |app|
      activerecord_railtie = app.railties.all.select {|railtie| railtie.class.to_s == "ActiveRecord::Railtie" }
      if activerecord_railtie
        require 'loofah/activerecord/active_record'
        require 'loofah/activerecord/xss_foliate'
      end
    end
  end
end
