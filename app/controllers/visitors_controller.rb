class VisitorsController < ApplicationController
  layout 'visitors'

  def index
    if params[:hs]
      session[:company_token] = params[:hs][:token]
      session[:link] = params[:hs][:link_login_only]
      session[:dst] = params[:hs][:dst]
      session[:mac] = params[:hs][:mac_esc]
    end
    @company = Company.find_by_token(session[:company_token])
    render_404 unless @company
  end
end
