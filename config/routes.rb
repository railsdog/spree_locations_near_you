Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :venues
  end
  get "/venues/fliter_venues_near_by", to: "venues#fliter_venues_near_by", as: "fliter_venues_near_by"
  get "/venues/drop_pins_on_load", to: "venues#drop_pins_on_load", as: "drop_pins_on_load"
  resources :venues, only: [:index]
end
