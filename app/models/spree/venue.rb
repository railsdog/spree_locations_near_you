class Spree::Venue < Spree::Base
  include Spree::Concerns::Locator
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
  validates :name, presence: true

  def set_full_address
    self.address = "#{street_address} #{city} #{state} #{zip} #{country}"
    self.save
  end
end
