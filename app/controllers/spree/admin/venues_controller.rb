module Spree
  module Admin
    class VenuesController < Spree::Admin::ResourceController
      before_action :find_venue, only: [:edit, :update, :destroy]
      before_filter :load_venues, only: [:index, :create, :update]

      private

      def load_venues
        per_page = params[:per_page] || 20
        @venues = Spree::Venue.page(params[:page]).per(per_page)
      end

      def find_venue
        @store = Spree::Venue.find(params[:id])
      end

      def venue_params
        params.require(:venue).permit( :name, :address, :street_address, :city, :country, :phone, :state, :website, :zip, :hidden)
      end
    end
  end
end
