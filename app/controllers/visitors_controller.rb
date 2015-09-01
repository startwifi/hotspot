class VisitorsController < ApplicationController

  layout 'visitors'

  def index
    render_404 if params[:hs].blank?

    token = params[:hs][:token]
    link  = params[:hs][:link_login_only]
    dst   = params[:hs][:dst]
    mac   = params[:hs][:mac_esc]
    # token = '3FpLB2WpmdG25CMCfwVmDoGj'
    # link  = 'http://192.168.88.1/login'
    # dst   = 'http://ukr.net' # ||= params[:hs][:dst] # if company.vk.redirect_url.any? redirect
    # mac   = 'b8:8d:12:42:03:6e'
    session[:link] = link
    session[:dst] = dst
    session[:mac] = mac
    session[:company_token] = token
    # session[:auth_link] = make_link(link, dst, mac)
    # session[:dst] = dst
  end

end
