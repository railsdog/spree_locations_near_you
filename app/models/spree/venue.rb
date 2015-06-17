class Spree::Venue < ActiveRecord::Base
  include Spree::Concerns::Locator
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
  validates :name, presence: true

  def set_full_address
    address_parts = [self.street_address, self.city, self.state, self.zip, self.country].join(" ").gsub(/\s+/, " ")
    self.address = address_parts
    self.save
  end
end
