module Spree
  class VenuesController < Spree::BaseController
    def index
      @stores = Spree::Store.all
    end
    # miles is a ghost field check result object.miles
    def venues_near_by
      user_location = Geocoder.coordinates(params[:zipcode])
      if !user_location.address.blank?
        @venues_near_by = Spree::Venue.by_distance_from_latlong(user_location.latitude, user_location.longitude)
        render "index"
      else
        # flash error
        # what to do if geocoder does not find an addres?
      end
    end
  end
end
