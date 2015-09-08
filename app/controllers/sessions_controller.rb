class SessionsController < ApplicationController

  def create
    # render json: request.env['omniauth.auth']
    # return
    company = Company.find_by_token(session[:company_token])
    user = User.from_omniauth(request.env['omniauth.auth'], company)
    session[:user_access_token] = request.env['omniauth.auth']['credentials']['token']
    if user.provider == 'twitter'
      session[:user_token] = request.env['omniauth.auth']['credentials']['token']
      session[:user_secret] = request.env['omniauth.auth']['credentials']['secret']
    end
    user.add_event(:login)
    session[:user_id] = user.id
    if company
      redirect_to widget_path
    else
      render_404
    end
  end

  def destroy
    user = User.find(session[:user_id])
    user.add_event(:logout)
    reset_session
    redirect_to auth_url, notice: 'Signed out!'
  end

  def failure
    redirect_to auth_url, alert: "Authentication error: #{params[:message].humanize}"
  end

end
