module Spree
  class VenuesController < Spree::BaseController
    def index
      @stores = Spree::Store.all
    end

    def venues_near_by
      user_location = Spree::Venue.create(address: params[:zipcode])
      @venues_near_by = Spree::Venue.by_distance_from_latlong(user_location.latitude, user_location.longitude)
      render "index"
    end
  end
end
# needs to be move into the gem