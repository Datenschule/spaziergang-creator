Rails.application.routes.draw do
  devise_for :users
  root 'static#index'

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :walks, only: [:index, :show]
    end
  end

  resources :walks do
    get '/private', to: 'walks#private', on: :collection

    resources :stations, shallow: true do
      get '/sort', to: 'stations#sort', on: :collection
      put '/sort', to: 'stations#update_after_sort', on: :collection

      resources :subjects, shallow: true, except: [:index] do
        resources :pages, shallow: true do
          get '/sort', to: 'pages#sort', on: :collection
          put '/sort', to: 'pages#update_after_sort',  on: :collection
        end
      end
    end
  end
end
