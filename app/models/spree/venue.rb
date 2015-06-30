class Spree::Venue < ActiveRecord::Base
  include Spree::Concerns::Locator
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
  validates :name, presence: true

  def set_full_address
    self.address = "#{street_address} #{city} #{state} #{zip} #{country}"
    self.save
  end

  def self.add_letter(collection)
    counter = 0
    letter = ["A", "B", "C", "D", "E"]
    collection.try(:each) do |v|
      v.letter = letter[counter]
      counter = counter + 1
      v.save
    end
    collection
  end
end
