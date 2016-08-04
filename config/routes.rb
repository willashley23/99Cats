Rails.application.routes.draw do
  resources :cats
  resources :cat_rental_requests
  resource :session
  resources :users
end
