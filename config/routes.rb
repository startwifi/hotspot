Rails.application.routes.draw do
  namespace :sms do
    get 'auth', to: 'auth#index'
    post 'auth/send_sms'
    match 'auth/validate', via: [:get, :post]
  end

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
  resource  :stats,     only: :show
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

  resources :routers
  resources :users, only: [:index, :show]
  resources :devices, only: :show
  resources :companies do
    member do
      put :hold
      get :suspended
    end
    get  '/new_admin', to: 'companies#new_admin',    on: :member
    post '/admin',     to: 'companies#create_admin', on: :member
  end
  resources :pages, only: :tos do
     collection do
      get 'tos'
      get 'tos_edit'
      put 'tos_update'
    end
  end
  post '/events/by_date',           to: 'events#by_date',   as: 'events_by_date'
  get '/event/:provider/subscribe', to: 'events#subscribe', as: 'event_subscribe'
  get '/event/:provider/post',      to: 'events#post',      as: 'event_post'
  get '/event/:provider/auth',      to: 'events#auth',      as: 'event_auth'
  get '/event/:provider/is_member', to: 'events#is_member', as: 'event_member'
  get '/auth/:provider/callback',   to: 'sessions#create'
  get '/auth/failure', to: 'sessions#failure'
  get '/auth', to: 'visitors#index'

  resources :stats, only: :show do
    collection do
      get :social_networks
      get :gender
      get :activity
      get :events
    end
  end
end
