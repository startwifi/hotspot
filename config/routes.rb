Rails.application.routes.draw do
  root to: 'home#index'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/signin',       to: 'sessions#new',     as: :signin
  get '/signout',      to: 'sessions#destroy', as: :signout
  get '/auth/failure', to: 'sessions#failure'
end
