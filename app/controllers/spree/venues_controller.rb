module Spree
  class VenuesController < Spree::BaseController
    def index
      @stores = Spree::Store.all
    end

    def venues_near_by
      user_location = Spree::Venue.create(address: params[:zipcode])
      if !user_location.nil?
        @venues_near_by = Spree::Venue.by_distance_from_latlong(user_location.latitude, user_location.longitude)
      else
        # what to do if geocoder does not find an addres?
      end
      render "index"
    end
  end
end
