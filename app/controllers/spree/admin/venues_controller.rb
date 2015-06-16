module Spree
  module Admin
    class VenuesController < Spree::Admin::ResourceController

      def index
        @venues = Spree::Venue.all
        @venue = Spree::Venue.new
        # show all venues
      end

      def new
        # form to create new venue
      end

      def edit
        #edit venue
      end

      def create
        # create new venue
      end

      def delete
        # delete new venue
      end

    end 
  end
end
