module Spree
  class VenuesController < Spree::BaseController
    def index
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
  end
end
