module Spree
  class VenuesController < Spree::BaseController


    def index
      user_location = Geocoder.coordinates(params[:zipcode].first)

      respond_to do |format|
        format.html do
          if user_location.present?
            @venues_near_by = Spree::Venue.by_distance_from_latlong(user_location[0], user_location[1])
          render :index
          else
            # render json:{ message: "There are no stores within 50 miles"}
          end
        end
        format.json do
          if user_location.present?
            @venues_near_by = Spree::Venue.by_distance_from_latlong(user_location[0], user_location[1])
          render json:{ venues: @venues_near_by, user_location: user_location}
          else
            render json:{ message: "There are no stores within 50 miles"}
          end
        end
      end
    end

    def fliter_venues_near_by
      venues = nil

      user_location = Geocoder.coordinates("94103")
      venues_near_by = Spree::Venue.by_distance_from_latlong(user_location[0], user_location[1])

      if params[:rank]
        venues = venues_near_by.select {|v| v.rank == params[:rank]}
      end

      if venues.present?
        render json:{ venues: venues, user_location: user_location}
      else
        render json:{ message: "There are no stores within 50 miles"}
      end
    end
  end
end
