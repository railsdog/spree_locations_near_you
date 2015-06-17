module Spree
  module Admin
    class VenuesController < Spree::Admin::ResourceController
      before_action :find_venue, only: [:edit, :update, :destroy]
      before_filter :load_venues, only: [:index, :create, :update]

      def index
      end

      def new
        @venue = Spree::Venue.new
      end

      def create
        @venue = Spree::Venue.new(venue_params)
        @venue.set_full_address
        if @venue.save
          flash[:success] = Spree.t('success.created_venue')
          redirect_to admin_venues_path
        else
          flash[:error] = Spree.t('error')
          render :index
        end
      end

      def edit
      end

      def update
        @venue.set_full_address
        if @venue.update_attributes(venue_params)
          redirect_to admin_venues_path
          flash[:success] = Spree.t('success.updated_venue')
        else
          flash[:error] = Spree.t('error')
          render :edit
        end
      end


      def destroy
        @venue.destroy
        flash[:success] = Spree.t('success.deleted_venue')
        redirect_to admin_venues_path
      end

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
