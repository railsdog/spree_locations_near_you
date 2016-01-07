module Spree
  class VenuesController < Spree::StoreController
    before_filter :get_venues_country

    def index
      if params[:zipcode].present?
        session[:location] = Geocoder.coordinates(params[:zipcode])
        @venues = @venues.by_distance_from_latlong(session[:location][0], session[:location][1])
      elsif session[:location].present?
        @venues = @venues.by_distance_from_latlong(session[:location][0], session[:location][1])
      elsif session[:location].nil?
        session[:location] = Geocoder.coordinates('19002')
        @venues = @venues.by_distance_from_latlong(session[:location][0], session[:location][1])
      else
        @venues = @venues.all.limit(max_results_returned)
      end

      @venues_near_by = @venues.limit(max_results_returned)

      respond_to do |format|
        format.html do
          render :index
        end

        format.json do
          if session[:location].present?
            render json:{ venues: @venues_near_by, user_location: session[:location]}
          else
            render json:{ message: "There are no stores available.", venues: @venues_near_by}
          end
        end
      end
    end

    def drop_pins_on_load
      if session[:location].present?
        user_location = Spree::Venue.create(address: session[:location] )
        @venues = @venues.by_distance_from_latlong(user_location.latitude, user_location.longitude)
        @venues_near_by = @venues.limit(max_results_returned)
        render json:{ venues: @venues_near_by }
      end
    end

    def fliter_venues_near_by
      user_location = session[:location]
      venues = @venues.by_distance_from_latlong(user_location[0], user_location[1])

      venue_results = venues.where(rank: params[:rank].keys).limit(max_results_returned)

      if venue_results.present?
        render json:{ venues: venue_results, user_location: user_location}
      else
        render json:{ message: "There are no stores available", user_location: user_location, venues: venue_results}
      end
    end

    private

    def get_venues_country
      if current_currency == 'CAD'
        @venues = Spree::Venue.in_canada
      else
        @venues = Spree::Venue.in_usa
      end
    end

    def max_results_returned
      3
    end
  end
end
