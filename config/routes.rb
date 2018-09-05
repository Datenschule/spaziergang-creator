Rails.application.routes.draw do
  root 'static#index'

  scope '/:locale', locale: /de|en/, defaults: {format: 'html'} do
    devise_for :users

    resources :users, only: [:update, :destroy]

    root 'static#index'

    get '/onboarding', controller: :static, action: :onboarding
    get '/impressum', controller: :static, action: :impressum
    get '/datenschutzerklaerung', controller: :static, action: :data_protection

    resources :admin do
    end

    resources :walks do
      get '/private', to: 'walks#private', on: :collection
      get '/route', to: 'walks#courseline', on: :member
      put '/route', to: 'walks#save_courseline', on: :member

      resources :stations, shallow: true do
        get '/sort', to: 'stations#sort', on: :collection
        put '/sort', to: 'stations#update_after_sort', on: :collection

        resources :subjects, shallow: true, except: [:index] do
          resources :pages, shallow: true do
            get '/sort', to: 'pages#sort', on: :collection
            put '/sort', to: 'pages#update_after_sort', on: :collection
          end
        end
      end
    end
  end

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :walks, only: [:index, :show]
    end
  end
end
