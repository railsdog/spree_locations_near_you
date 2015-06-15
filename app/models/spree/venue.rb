class Spree::Venue < ActiveRecord::Base
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
  include SpreeLocationNearYou
end

# Spree::Venue.by_distance_from_latlong(37.766340, -122.416815)