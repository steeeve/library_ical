Rails.application.routes.draw do

  root 'home#index'

  resources :loans, only: [:index]

end
