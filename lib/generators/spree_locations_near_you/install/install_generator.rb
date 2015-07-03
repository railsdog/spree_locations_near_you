module SpreeLocationsNearYou
  module Generators
    class InstallGenerator < Rails::Generators::Base

      class_option :auto_run_migrations, :type => :boolean, :default => false

      def add_javascripts
        append_file 'vendor/assets/javascripts/spree/frontend/all.js', "//= require spree/frontend/spree_locations_near_you\n"
        append_file 'vendor/assets/javascripts/spree/backend/all.js', "//= require spree/backend/spree_locations_near_you\n"
      end

      def add_stylesheets
        inject_into_file 'vendor/assets/stylesheets/spree/frontend/all.css', " *= require spree/frontend/spree_locations_near_you\n", :before => /\*\//, :verbose => true
        inject_into_file 'vendor/assets/stylesheets/spree/backend/all.css', " *= require spree/backend/spree_locations_near_you\n", :before => /\*\//, :verbose => true
      end

      def add_migrations
        run 'bundle exec rake railties:install:migrations FROM=spree_locations_near_you'
      end

      def auto_migrate?
        ENV['AUTO_RUN_MIGRATIONS'] =~ /true/i
      end

      def run_migrations
        # hiding this inside parent method so it's not auto-run by rails generator
        def migration_prompt_approved?
          result = ask('Would you like to run the migrations now? [Y/n]')
          !(result =~ /n/i)
        end

        if auto_migrate? || migration_prompt_approved?
          run 'bundle exec rake db:migrate'
        else
          puts 'Skipping rake db:migrate, don\'t forget to run it!'
        end
      end

    end
  end
end
