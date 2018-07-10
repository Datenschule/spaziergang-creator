Rails.application.routes.draw do
  root 'static#index'

  resources :walks do
    resources :stations
  end
end
