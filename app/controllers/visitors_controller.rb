class VisitorsController < ApplicationController

  def index
  end

  def login
    link = params[:hs][:link_login]
    mac  = params[:hs][:mac_esc]
    login_link = "#{link}&username=T-#{mac}"
    session[:login_link] = login_link
    render :index
  end

end
