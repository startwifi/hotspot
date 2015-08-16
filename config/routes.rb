Rails.application.routes.draw do
  devise_for :admins, path: '/', path_names: { sign_in: 'login', sign_up: 'new',
    sign_out: 'logout', password: 'secret', registration: 'profile' }
  as :admin do
    get '/profile/edit', to: 'devise/registrations#edit',   as: 'edit_admin_registration'
    put '/profile',      to: 'devise/registrations#update', as: 'admin_registration'
  end
  root to: 'home#index'
  resource  :dashboard, only: :show
  resources :users
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/signin',       to: 'sessions#new',     as: :signin
  get '/signout',      to: 'sessions#destroy', as: :signout
  get '/auth/failure', to: 'sessions#failure'
  get '/social',       to: 'visitors#index'
  get '/auth_guest',   to: 'visitors#login'
end
