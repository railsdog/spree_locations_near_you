module Spree
  class VenuesController < Spree::BaseController
    def index
      @zipcode = params[:zipcode]
      if params[:zipcode].present?
        user_location = Spree::Venue.create(address: params[:zipcode] )
        session[:location] = [user_location.latitude, user_location.longitude]
        @venues = Spree::Venue.by_distance_from_latlong(user_location.latitude, user_location.longitude)
      elsif session[:location].present?
        user_location = Spree::Venue.create(address: session[:location] )
        @venues = Spree::Venue.by_distance_from_latlong(user_location.latitude, user_location.longitude)
      elsif session[:location].nil?
        location = Spree::Venue.create(address: "10005" )
        session[:location] = [location.latitude, location.longitude]
      else
        @venues_near_by = Spree::Venue.all.limit(5)
      end

      respond_to do |format|
        format.html do
          if user_location.present?
            @venues_near_by = @venues.limit(5).select {|v| v.miles < 50 }
            user_location.destroy
          else
            flash[:error] = "There are no stores within 50 miles"
          end
        end

        format.json do
          if user_location.present?
            @venues_near_by = @venues.limit(5).select {|v| v.miles < 50 }
            render json:{ venues: @venues_near_by, user_location: session[:location]}
          else
            render json:{ message: "There are no stores within 50 miles", venues: @venues_near_by}
          end
        end
      end
    end

    def drop_pins_on_load
      if session[:location].present?
        user_location = Spree::Venue.create(address: session[:location] )
        @venues = Spree::Venue.by_distance_from_latlong(user_location.latitude, user_location.longitude)
        @venues_near_by = @venues.limit(5).select {|v| v.miles < 50 }
        render json:{ venues: @venues_near_by }
      end
    end

    def fliter_venues_near_by
      venues_list = []
      user_location = session[:location]
      venues = Spree::Venue.by_distance_from_latlong(user_location[0], user_location[1])

      # Specific to G&G
      if params[:rank].present?
         venues_near_by = venues.select {|v| params[:rank].keys.include?(v.rank) && v.miles < 51}
         venues_near_by.present? if venues_list += venues_near_by
      end

      if venues_list.present?
        render json:{ venues: venues_list, user_location: user_location}
      else
        render json:{ message: "There are no stores within 50 miles", user_location: user_location, venues: venues_list}
      end
    end
  end
end
