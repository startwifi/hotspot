class SessionsController < ApplicationController
  before_action :load_company, only: %w(create setup)
  #before_action :load_router, only: %w(create setup)
  #before_action :load_router_user, only: :create
  before_action :load_user, only: :create
  before_action :save_access_token, only: :create
  before_action :save_statistics, only: :create

  def create
    return render_404 unless @company && @user
    session[:user_id] = @user.id
    redirect_to widget_path
  end

  def failure
    redirect_to auth_url, alert: "Authentication error: #{params[:message].humanize}"
  end

  def setup
    api_credentials = OmniauthSetupService.new(@company, params[:provider]).call
    request.env['omniauth.strategy'].options.merge!(api_credentials)
    render plain: 'Omniauth setup phase', status: 404
  end

  private

  def load_company
    @company = Company.find_by_token(session[:company_token])
    render_404 unless @company
  end

  def load_router
    @router = Router.find_by_token(session[:router_token])
    render_404 unless @router
  end

  def load_router_user
    @router.get_wifi_users
  end

  def load_user
    @user = CreateWithOmniauthService.new(@company, request.env['omniauth.auth']).call
  end

  def save_statistics
    StatisticService.new(@user, request).call
  end

  def credentials
    @credentials ||= request.env['omniauth.auth']['credentials']
  end

  def save_access_token
    case @user.provider
    when 'facebook'
      session[:user_token] = credentials['token']
    when 'twitter'
      session[:user_token] = credentials['token']
      session[:user_secret] = credentials['secret']
    when 'odnoklassniki'
      session[:user_token] = credentials['refresh_token']
    when 'vkontakte'
      session[:user_token] = credentials['token']
    end
  end
end
