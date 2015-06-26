module Spree
  class VenuesController < Spree::BaseController
    def index
      @venues_near_by = nil
      user_location = Geocoder.coordinates(params[:zipcode].first)
      @venues = Spree::Venue.by_distance_from_latlong(user_location[0], user_location[1])
      respond_to do |format|
        format.html do
          if user_location.present?
           # @venues.each do  |v| 
           #    if v.rank == "sliver" && v.miles < 50 
           #     @venues_near_by + [v]
           #    end
            # binding.pry
            @venues_near_by = @venues
            # end
          render :index
          else
            #come back and do something here.
            # render json:{ message: "There are no stores within 50 miles"}
          end
        end
        format.json do
          if user_location.present?
            @venues_near_by = Spree::Venue.by_distance_from_latlong(user_location[0], user_location[1])
            @venues_near_by.select {|v| v.rank == "sliver" && v.miles < 50 }
            @venues_near_by = @venues_near_by.select {|v| v.miles < 50 }
          render json:{ venues: @venues_near_by, user_location: user_location}
          else
            render json:{ message: "There are no stores within 50 miles"}
          end
        end
      end
    end

    def fliter_venues_near_by
      venues_list = []
      user_location = Geocoder.coordinates("94103")
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
        render json:{ venues: "There are no stores within 50 miles", user_location: user_location}
      end
    end
  end
end
