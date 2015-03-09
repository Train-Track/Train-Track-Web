Rails.application.routes.draw do

  root to: 'static_pages#index'
  get '/privacy', to: 'static_pages#privacy'
  get '/terms', to: 'static_pages#terms'
  get '/help', to: 'static_pages#help'
  get '/data-feeds', to: 'static_pages#data_feeds'
  get '/download', to: 'static_pages#download'

  get '/stations', to: 'stations#index'
  get '/stations/all', to: 'stations#all'
  get '/stations/:crs', to: 'stations#show'
  get '/stations/:crs/departures', to: 'stations#departures'
  get '/stations/:crs/arrivals', to: 'stations#arrivals'

  get '/services/:service_id', to: 'services#show'

  get '/operators', to: 'operators#index'
  get '/operators/all', to: 'operators#all'
  get '/operators/:code', to: 'operators#show'

  put 'users', to: 'users#update'
  devise_for :users, path: "", path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    password: 'secret',
    confirmation: 'verification',
    unlock: 'unblock',
    registration: 'users',
    sign_up: 'new'
  }, controllers: {
    sessions: 'sessions',
    registrations: 'registrations'
  }
  get '/users/:username', to: 'users#show', as: :user

  resources :badges, only: [:index, :show]

  get 'journeys/new', to: 'journey_legs#new', as: :new_journey_form
  post 'journeys', to: 'journey_legs#create', as: :new_journey
  resources :journeys, only: [:index, :show, :destroy] do
    resources :journey_legs, path: 'legs', except: [:index]
  end

end
