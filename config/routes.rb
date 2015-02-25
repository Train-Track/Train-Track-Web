Rails.application.routes.draw do

  root to: 'static_pages#index'
  get '/privacy', to: 'static_pages#privacy'
  get '/terms', to: 'static_pages#terms'
  get '/help', to: 'static_pages#help'

  get '/stations', to: 'stations#index'
  get '/stations', to: 'stations#index'
  get '/stations/:crs', to: 'stations#show'
  get '/stations/:crs/departures', to: 'stations#departures'
  get '/stations/:crs/arrivals', to: 'stations#arrivals'

  get '/services/:service_id', to: 'services#show'

  get '/operators', to: 'operators#index'
  get '/operators/:code', to: 'operators#show'

  devise_for :users, path: "", path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'users', sign_up: 'new' }
  get '/users/:username', to: 'users#show'

  resources :badges, only: [:index, :show]

  resources :journeys do
    resources :journey_legs, path: 'legs', except: [:index]
  end

end
