class VisitorsController < ApplicationController

  layout 'visitors'

  def index
    if Rails.env.production? || Rails.env.staging?
      render_404 if session[:company_token].blank?
      token = params[:hs][:token]
      link  = params[:hs][:link_login_only]
      dst   = params[:hs][:dst]
      mac   = params[:hs][:mac_esc]
    else
      token = Company.first.token
      link  = 'http://192.168.1.1/login'
      dst   = 'http://ukr.net'
      mac   = 'b8:8d:12:42:03:6e'
    end
    session[:link] = link
    session[:dst] = dst
    session[:mac] = mac
    session[:company_token] = token
    @company = Company.find_by_token(token)
  end

end
