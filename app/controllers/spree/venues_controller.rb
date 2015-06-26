module Spree
  class VenuesController < Spree::BaseController
    def index
      @venues = Spree::Venue.all
    end
    # miles is a ghost field check result object.miles
    def venues_near_by
      user_location = Geocoder.coordinates(params[:zipcode].first)
      if !user_location.blank?
        @venues_near_by = Spree::Venue.by_distance_from_latlong(user_location[0], user_location[1])
      render json:{ venues: @venues_near_by, user_location: user_location}
      else
        render json:{ message: "There are no stores within 50 miles"}
      end
    end

    def fliter_venues_near_by

      venues = nil

      user_location = Geocoder.coordinates("94103")
      venues_near_by = Spree::Venue.by_distance_from_latlong(user_location[0], user_location[1])
      if !params[:sliver].nil?
         venues = venues_near_by.select {|v| v.rank == "sliver"}
      elsif !params[:gold].nil?
        venues = venues_near_by.select {|v| v.rank == "gold"}
      elsif !params[:platinum].nil?
         venues = venues_near_by.select {|v| v.rank == "platinum"}
      end

      if venues.present?
        render json:{ venues: venues, user_location: user_location}
      else
        render json:{ message: "There are no stores within 50 miles"}
      end
    end
  end
end
