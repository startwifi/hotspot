class SessionsController < ApplicationController

  def new
    redirect_to '/auth/facebook'
  end

  def create
    # render json: request.env['omniauth.auth']
    user = User.from_omniauth(request.env['omniauth.auth'])
    user.add_event(:login)
    auth_link = session[:login_link]
    reset_session
    session[:user_id] = user.id
    if auth_link
      redirect_to auth_link
    else
      redirect_to social_path, notice: 'Signed in!'
    end
  end

  def destroy
    user = User.find(session[:user_id])
    user.add_event(:logout)
    reset_session
    redirect_to social_url, notice: 'Signed out!'
  end

  def failure
    redirect_to social_url, alert: "Authentication error: #{params[:message].humanize}"
  end

end
