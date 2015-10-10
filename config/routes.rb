Rails.application.routes.draw do
  devise_for :admins,
    path: '/',
    path_names: {
      sign_up: 'new',
      sign_out: 'logout',
      password: 'secret',
      registration: 'profile'
    }

  devise_scope :admin do
    root to: 'devise/sessions#new'
  end

  as :admin do
    get '/profile/edit', to: 'devise/registrations#edit',   as: 'edit_admin_registration'
    put '/profile',      to: 'devise/registrations#update', as: 'admin_registration'
  end

  resource  :dashboard, only: :show
  resource  :widget,    only: :show
  namespace :social do
    resource :vk, only: [:edit, :update]
    resource :fb, only: [:edit, :update]
    resource :tw, only: [:edit, :update]
    resource :in, only: [:edit, :update]
    resource :ok, only: [:edit, :update]
  end
  resource  :settings,  only: [:edit, :update] do
    member do
      get 'advanced'
      put 'advanced', to: 'settings#advanced_update'
    end
  end
  resources :users, only: [:index, :show]
  resources :companies do
    get  '/new_admin', to: 'companies#new_admin',    on: :member
    post '/admin',     to: 'companies#create_admin', on: :member
  end
  post '/events/by_date',           to: 'events#by_date',   as: 'events_by_date'
  get '/event/card',                to: 'events#card',      as: 'event_card'
  get '/event/:provider/subscribe', to: 'events#subscribe', as: 'event_subscribe'
  get '/event/:provider/post',      to: 'events#post',      as: 'event_post'
  get '/auth/:provider/callback',   to: 'sessions#create'
  get '/auth/failure', to: 'sessions#failure'
  get '/auth',         to: 'visitors#index'
end
