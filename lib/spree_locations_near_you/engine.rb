module SpreeLocationsNearYou
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'spree_locations_near_you'

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/models/concerns/**/*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc

    config.to_prepare do
      Rails.application.config.assets.precompile += %w(
      spree/frontend/gmap_venues.js
      spree/frontend/google.js
      spree/frontend/gmap.js
      )
    end
  end
end
