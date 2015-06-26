Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :venues
  end
  get "/venues/fliter_venues_near_by", to: "venues#fliter_venues_near_by", as: "fliter_venues_near_by"
    resources :venues, only: [:index]
end
