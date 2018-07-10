Rails.application.routes.draw do
  devise_for :users
  root 'static#index'

  resources :walks do
    resources :stations
  end
end
