class ApplicationController < ActionController::Base
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

  private

  def make_link(link, dst, mac)
    "#{link}?dst=#{dst}&username=T-#{mac}"
  end

  def router_url
    dst = case current_user.provider
          when 'vkontakte'
            unless current_user.company.vk.link_redirect.empty?
              current_user.company.vk.link_redirect
            else
              session[:dst]
            end
          when 'facebook'
            unless current_user.company.fb.link_redirect.empty?
              current_user.company.fb.link_redirect
            else
              session[:dst]
            end
          end
    make_link(session[:link], dst, session[:mac])
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
      redirect_to root_url, alert: "Access denied."
    end
  end

  def authenticate_user!
    if !current_user
      redirect_to root_url, alert: 'You need to sign in for access to this page.'
    end
  end

end
