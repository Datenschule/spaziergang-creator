Rails.application.routes.draw do
  devise_for :users
  root 'static#index'

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :walks, only: [:index, :show]
    end
  end

  resources :walks do
    collection do
      %i[private].each { |action| get action }
    end
  end

  resources :stations

  resources :subjects do
    resources :pages
  end
end
