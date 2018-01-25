Rails.application.routes.draw do

  root 'restaurants#index'

  resources :users, only: [:new, :create]

  get '/user/profile', to: 'users#show'
  post '/restaurants/:restaurant_id/reservations/confirmation', to: 'reservations#confirmation'

  resources :sessions, only: [:new, :create, :destroy]

  resources :restaurants do
    resources :reservations, only: [:show, :new, :create]
  end

end
