module Spree
  module Concerns
    module Locator
      extend ActiveSupport::Concern
      puts "**************you got here"
      included do
        scope :by_distance_from_latlong, -> (lat, lng) {
        # ** NOTE: postgres earthdistance orders points as (lng,lat) **
        # This method signature prefers lat,lng because that's how mapping is colloquially discussed.
        # The PG point() constructure requires lng,lat though so the ordering appears inverted at first glance.
        # Don't switch these unless you are 100% the current code is wrong
        start_loc   = "point(#{lng}, #{lat})"
        dealer_loc  = "point(#{table_name}.longitude, #{table_name}.latitude)"

        miles_apart = "(#{start_loc} <@> #{dealer_loc})"

        select("#{table_name}.*, #{miles_apart} miles")
        .where("#{table_name}.latitude IS NOT NULL")
        .where("#{table_name}.latitude IS NOT NULL")
        .order("#{miles_apart} ASC")
        }
      end
    end
  end
end
