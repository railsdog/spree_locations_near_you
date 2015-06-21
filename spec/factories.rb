require 'faker'
FactoryGirl.define do
  factory :spree_venue, :class => Spree::Venue do |f|
    f.name { Faker::App.name }
    f.street_address { Faker::Address.street_address }
    f.city { Faker::Address.city }
    f.country { Faker::Address.country }
    f.state { Faker::Address.state }
    f.zip { Faker::Address.zip_code }
  end
end