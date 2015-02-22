Rails.application.routes.draw do

  root to: 'static_pages#index'
  get '/stations', to: 'stations#index'
  get '/stations/:crs', to: 'stations#show'

end
