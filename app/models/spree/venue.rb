class Spree::Venue < ActiveRecord::Base
  include Spree::Concerns::Locator
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
  validates :name, presence: true
  # validates :street_address, presence: true
  # validates :city, presence: true
  # validates :zip, presence: true
  # validate :website_protocol_present

  def set_full_address
    self.address = "#{street_address} #{city} #{state} #{zip} #{country}"
    self.save
  end

  def website_protocol_present
    unless website.include?("http://") || website.include?("https://")
      errors.add(:website, 'Please add correct protocol. Example: http:// or https://')
    end
  end
end
