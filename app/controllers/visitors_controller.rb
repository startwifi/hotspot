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
    redirect_to suspended_company_path(@company) and return unless @company.try(:active)
    redirect_to sms_auth_path if @company.sms_auth.eql?('preauth') && !user_signed_in?
  end
end
