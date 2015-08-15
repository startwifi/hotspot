Rails.application.routes.draw do
  root to: 'visitors#index'
  resources :users
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/signin',       to: 'sessions#new',     as: :signin
  get '/signout',      to: 'sessions#destroy', as: :signout
  get '/auth/failure', to: 'sessions#failure'
  get '/login',        to: 'visitors#login'
end
