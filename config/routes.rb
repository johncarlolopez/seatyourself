Rails.application.routes.draw do

  root 'restaurants#index'

  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]

  resources :restaurants do
    resources :reservations, only: [:show, :new, :create]
  end

end
