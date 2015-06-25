module Spree
  class VenuesController < Spree::BaseController
    def index
      @venues = Spree::Venue.all
    end
    # miles is a ghost field check result object.miles
    def venues_near_by
      # binding.pry
      # user_location = Geocoder.coordinates(params[:zipcode].first)
      # if !user_location.blank?
      #   @venues_near_by = Spree::Venue.by_distance_from_latlong(user_location[0], user_location[1])
      #       def index
      # render json: @venues_near_by
      render :index
    # end
    #   else
    #     # flash error
    #     # what to do if geocoder does not find an addres?
    #   end
    end
  end
end
