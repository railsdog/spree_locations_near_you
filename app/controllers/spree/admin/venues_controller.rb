module Spree
  module Admin
    class VenuesController < Spree::Admin::ResourceController
      before_action :find_store, only: [:edit, :update, :destroy]

      def index
        load_venues
        @venue = Spree::Venue.new
      end

      def edit
        #edit venue
      end

      def create
        @venue = Spree::Venue.new(venue_params)
        if @venue.save
           redirect_to admin_venues_path
        else
          load_venues
          flash[:error] = 'There was an error.'
          render :index
        end
      end

      def destroy
        @venue.destroy
        redirect_to admin_venues_path
      end

      private

       def load_venues
         per_page = params[:per_page] || 20
         @venues = Spree::Venue.page(params[:page]).per(per_page)
       end

       def find_store
         @store = Spree::Store.find_by id: params[:id]
       end

       def venue_params
         params.require(:venue).permit( :name, :address )
       end

    end 
  end
end
