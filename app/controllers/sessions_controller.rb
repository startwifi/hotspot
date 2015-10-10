class SessionsController < ApplicationController

  def create
    # render json: request.env['omniauth.auth']
    # return
    company = Company.find_by_token(session[:company_token])
    user = User.from_omniauth(request.env['omniauth.auth'], company)
    save_access_token(user.provider)
    user.add_event(:login, user.provider, company)
    session[:user_id] = user.id
    if company
      redirect_to widget_path
    else
      render_404
    end
  end

  def failure
    redirect_to auth_url, alert: "Authentication error: #{params[:message].humanize}"
  end

  private

  def save_access_token(provider)
    case provider
    when 'facebook'
      session[:user_token] = request.env['omniauth.auth']['credentials']['token']
    when 'twitter'
      session[:user_token] = request.env['omniauth.auth']['credentials']['token']
      session[:user_secret] = request.env['omniauth.auth']['credentials']['secret']
    when 'odnoklassniki'
      session[:user_token] = request.env['omniauth.auth']['credentials']['refresh_token']
    end
  end
end
