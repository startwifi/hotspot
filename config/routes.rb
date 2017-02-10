Rails.application.routes.draw do
  resources :landings, only: :show

  get '/:agreement', to: 'agreements#show', constraints: { subdomain: '', agreement: /(tos|privacy_policy)/ }

  match '/', to: 'landings#show', constraints: { subdomain: '' }, via: :get

  constraints AdminSubdomain do
    devise_for :admins,
      path: '/',
      path_names: {
        sign_up: 'new',
        sign_out: 'logout',
        password: 'secret',
        registration: 'profile'
      }

    root to: 'dashboards#show'

    as :admin do
      get '/profile/edit', to: 'devise/registrations#edit', as: 'edit_admin_registration'
      put '/profile', to: 'devise/registrations#update', as: 'admin_registration'
    end

    resource :dashboard, only: :show
    resource :stats, only: :show
    resource :settings, only: %w(edit update)

    resources :agreements
    resources :users, only: %w(index show)
    resources :devices, only: %w(index show)
    resources :routers
    resources :stats, only: :show do
      collection do
        get :social_networks
        get :gender
        get :activity
        get :events
      end
    end
    resources :companies do
      resources :admins, only: %w(new create)
      member do
        put :hold
        get :suspended
      end
    end
    resources :pages, only: :tos do
      collection do
        get :tos
        get :tos_edit
        put :tos_update
      end
    end
    namespace :social do
      resource :vk, only: %w(edit update)
      resource :fb, only: %w(edit update)
      resource :tw, only: %w(edit update)
      resource :in, only: %w(edit update)
      resource :ok, only: %w(edit update)
      resource :sms, only: %w(edit update)
      resource :guest, only: %w(edit update)
    end
    post '/events/by_date', to: 'events#by_date', as: 'events_by_date'
  end

  constraints OauthSubdomain do
    resource :widget, only: :show

    namespace :sms do
      get 'authorize', to: 'auth#index'
      post 'auth/send_sms'
      match 'auth/validate', via: %w(get post)
    end

    post '/password', to: 'visitors#auth_by_password'
    get '/:provider/subscribe', to: 'events#subscribe', as: 'event_subscribe'
    match '/:provider/post', to: 'events#post', as: 'event_post', via: [:get, :post]
    get '/:provider/auth', to: 'events#auth', as: 'event_auth'
    get '/:provider/is_member', to: 'events#is_member', as: 'event_member'
    get '/:provider/callback', to: 'sessions#create'
    get '/:provider/setup', to: 'sessions#setup'
    get '/failure', to: 'sessions#failure'
    get '/', to: 'visitors#index', as: :auth
  end
end
