Rails.application.routes.draw do

  root 'restaurants#index'

  resources :restaurants do
    resources :reservations, only: [:show, :new, :create]
  end

end
