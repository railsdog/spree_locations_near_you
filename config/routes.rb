Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :venues
  end
   get "/venues/near_by", to: "venues#venues_near_by", as: "venues_near_by"
    resources :venues
end
