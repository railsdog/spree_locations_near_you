module Spree
  class VenuesController < Spree::BaseController
    def index
      # user_location = Geocoder.coordinates(params[:zipcode].first)
      user_location = Spree::Venue.create(address: params[:zipcode] ) 

      session[:location] = [user_location.latitude, user_location.longitude]
      @venues = Spree::Venue.by_distance_from_latlong(user_location.latitude, user_location.longitude)

      respond_to do |format|
        format.html do
          if user_location.present?
            @venues_near_by = @venues.select {|v| v.miles < 50 }
            user_location.destroy
          render :index
          else
            #come back and do something here.
            # render json:{ message: "There are no stores within 50 miles"}
          end
        end

        format.json do
          if user_location.present?
            @venues_near_by = Spree::Venue.by_distance_from_latlong(session[:location])
            @venues_near_by.select {|v| v.rank == "sliver" && v.miles < 50 }
            @venues_near_by = @venues_near_by.select {|v| v.miles < 50 }
          render json:{ venues: @venues_near_by, user_location: user_location}
          else
            render json:{ message: "There are no stores within 50 miles", venues: nil}
          end
        end
      end
    end

    def fliter_venues_near_by
      venues_list = []
      user_location = Geocoder.coordinates(session[:user_location])
      venues = Spree::Venue.by_distance_from_latlong(user_location[0], user_location[1])

      if params[:sliver].present?
         sliver_near_by = venues.select {|v| v.rank == "sliver" && v.miles < 51}
         sliver_near_by.present? if venues_list+= sliver_near_by
      end
      if params[:gold].present?
         gold_near_by = venues.select {|v| v.rank == "gold" && v.miles < 51}
         gold_near_by.present? if venues_list+= gold_near_by
      end
      if params[:platinum].present?
         platinum_near_by = venues.select {|v| v.rank == "platinum" && v.miles < 51}
         platinum_near_by.present? if venues_list+= platinum_near_by
      end
      if venues_list.present?
        render json:{ venues: venues_list, user_location: user_location}
      else 
        render json:{ message: "There are no stores within 50 miles", user_location: user_location, venues: nil}
      end
    end

    protected

    def set_user_location(location)
      session[:user_location] = location
    end
    def user_location
      session[:user_location]
    end
  end
end
