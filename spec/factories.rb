FactoryGirl.define do 
  factory :spree_venue do
    name { Faker::App.name }
    street_address { Faker::Address.street_address }
    city { Faker::Address.city }
    country { Faker::Address.country }
    state { Faker::Address.state }
    zipcode { Faker::Address.zip_code }
    trait :admin do
      admin true
    end
  end
end
