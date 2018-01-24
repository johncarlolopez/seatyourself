Rails.application.routes.draw do

  root 'restaurants#index'

  resources :users, only: [:new, :create]

  get '/user/profile', to: 'users#show'

  resources :sessions, only: [:new, :create, :destroy]

  resources :restaurants do
    resources :reservations, only: [:show, :new, :create]
  end

end
