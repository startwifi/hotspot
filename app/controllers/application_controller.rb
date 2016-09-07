class ApplicationController < ActionController::Base
  include HotSpot::LocaleSwitcher # see {root}/lib folder

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def current_ability
    @current_ability ||= Ability.new(current_admin)
  end

  helper_method :get_avatar
  helper_method :current_user
  helper_method :user_signed_in?
  helper_method :correct_user?
  helper_method :make_link
  helper_method :router_url
  helper_method :mac_address

  private

  def make_link(link, dst, mac)
    "#{link}?username=T-#{mac}&dst=#{dst}"
  end

  def router_url
    link = current_user ? destination_link : session[:dst]
    make_link(session[:link], link, session[:mac])
  end

  def destination_link
    provider = case current_user.provider
               when 'vkontakte' then 'vk'
               when 'facebook'  then 'fb'
               when 'twitter'   then 'tw'
               when 'instagram' then 'in'
               when 'odnoklassniki' then 'ok'
               else
                 current_user.provider
               end

    provider_class = current_user.company.send(provider)
    if provider_class && provider_class.try(:link_redirect?)
      provider_class.link_redirect
    else
      session[:dst]
    end
  end

  def render_404
    raise ActionController::RoutingError.new('Not Found')
  end

  def get_avatar
    hash = Digest::MD5.hexdigest(current_admin.email)
    "http://www.gravatar.com/avatar/#{hash}?s=30&d=identicon"
  end

  def current_user
    begin
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue
      nil
    end
  end

  def user_signed_in?
    return true if current_user
  end

  def correct_user?
    @user = User.find(params[:id])
    unless current_user == @user
      redirect_to root_url, alert: t('.access_denied')
    end
  end

  def authenticate_user!
    if !current_user
      redirect_to root_url, alert: t('.need_authorization')
    end
  end

  # TODO: Improve this method
  def mac_address(mac)
    mac.gsub('%3A',':')
  end
end
