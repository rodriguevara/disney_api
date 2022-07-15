Rails.application.routes.draw do
  get 'users/index'
  devise_for :users
  resources :characters
  resources :movies
  resources :genres
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  match '/users',   to: 'users#index',   via: 'get'
  
  # Defines the root path route ("/")
  # root "articles#index"

end
