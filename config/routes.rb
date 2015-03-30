Rails.application.routes.draw do

  root to: 'static_pages#index'
  get '/privacy', to: 'static_pages#privacy'
  get '/terms', to: 'static_pages#terms'
  get '/help', to: 'static_pages#help'
  get '/data-feeds', to: 'static_pages#data_feeds'
  get '/download', to: 'static_pages#download'

  get '/stations', to: 'stations#index'
  get '/stations/all', to: 'stations#all'
  get '/stations/:uuid', to: 'stations#show'
  get '/stations/:uuid/departures', to: 'stations#departures'
  get '/stations/:uuid/arrivals', to: 'stations#arrivals'
  get '/stations/:uuid/tube', to: 'stations#tube'

  get '/services/:service_id', to: 'services#show'

  get '/operators', to: 'operators#index'
  get '/operators/all', to: 'operators#all'
  get '/operators/:uuid', to: 'operators#show'

  namespace :tube do
    root to: 'static_pages#index'
    get '/lines', to: 'lines#index'
    get '/lines/:uuid', to: 'lines#show'
  end

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

  get '/badges', to: 'badges#index'
  get '/badges/all', to: 'badges#all'
  get '/badges/:uuid', to: 'badges#show'
 
  get 'journeys/new', to: 'journey_legs#new', as: :new_journey_form
  post 'journeys', to: 'journey_legs#create', as: :new_journey
  resources :journeys, only: [:index, :show, :destroy] do
    resources :journey_legs, path: 'legs', except: [:index]
  end

end
