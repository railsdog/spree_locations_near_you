class Spree::Venue < ActiveRecord::Base
  include Spree::Concerns::Locator
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
  
  def set_full_address
    address_parts = [self.street_address, self.city, self.state, self.zip, self.country].join(" ").gsub(/\s+/, " ")
    self.address = address_parts
    self.save
  end
end

# Spree::Venue.by_distance_from_latlong(37.766340, -122.416815)