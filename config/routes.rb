Rails.application.routes.draw do
  root 'home#index'
  resource :session, only: [:new, :create, :destroy]

  namespace :oauth do 
    resources :authorizations, only: [:new, :create]
  end
end
