Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :venues
  end
  resources :venues, only: [:index]
end
