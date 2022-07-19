Rails.application.routes.draw do
  # get 'current_user/index'
  # devise_for :users, path: '', path_names: {
  #   sign_in: 'login',
  #   sign_out: 'logout',
  #   registration: 'signup'
  # },
  # controllers: {
  #   sessions: 'users/sessions',
  #   registrations: 'users/registrations'
  # }
  devise_for :users, skip: %i[registrations sessions passwords]
  devise_scope :user do
    post '/signup', to: 'registrations#create'
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
  end
  resources :characters
  resources :movies
  resources :genres
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/current_user', to: 'current_user#index'
  #match '/users',   to: 'users#index',   via: 'get'

  # Defines the root path route ("/")
  # root "articles#index"

end
