Rails.application.routes.draw do

  devise_for :users, skip: %i[registrations sessions passwords]
  devise_scope :user do
    post '/signup', to: 'registrations#create' #registro
    post '/login', to: 'sessions#create' #inicio de sesión
    delete '/logout', to: 'sessions#destroy' #cierre de sesión
  end
  resources :characters
  resources :movies
  resources :genres
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/current_user', to: 'current_user#index' #permite ver el usuario actual


end
