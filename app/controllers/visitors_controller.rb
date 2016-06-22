class VisitorsController < ApplicationController
  layout 'visitors'

  def index
    if params[:hs]
      session[:company_token] = params[:hs][:token]
      session[:link] = params[:hs][:link_login_only]
      session[:dst] = params[:hs][:dst]
      session[:mac] = mac_address(params[:hs][:mac_esc])
    end
    @company = Company.find_by_token(session[:company_token])
    render_404 unless @company
    redirect_to suspended_company_path(@company) and return unless @company.try(:active)

    if @company.sms.action.eql?('ident') || @company.sms.action.eql?('ident_auth')
      device = @company.devices.find_by_mac(session[:mac])
      return redirect_to sms_auth_path unless device
      render 'widgets/sms/adv' if @company.sms.action.eql?('ident') && @company.sms.adv
    end
  end
end
