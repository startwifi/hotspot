class VisitorsController < ApplicationController

  layout 'visitors'

  def index
  end

  def login
    render_404 if params[:hs].blank?

    link = params[:hs][:link_login]
    mac  = params[:hs][:mac_esc]
    login_link = "#{link}&username=T-#{mac}"
    session[:login_link] = login_link
    render :index
  end

end
