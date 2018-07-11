Rails.application.routes.draw do
  devise_for :users
  root 'static#index'

  resources :walks do

    collection do
      %i[private].each { |action| get action }
    end
  end

  resources :stations
  resources :subjects
end
