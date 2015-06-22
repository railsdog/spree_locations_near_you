module Spree
  module Admin
    class VenuesController < Spree::Admin::ResourceController
      before_action :find_venue, only: [:edit, :update, :destroy]
      before_filter :load_venues, only: [:index, :create, :update]
      after_action :set_full_address, only: [:create, :update]

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

      def set_full_address
        @venue.set_full_address
      end
    end
  end
end
