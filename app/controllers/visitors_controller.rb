class VisitorsController < ApplicationController
  before_action :save_params
  before_action :load_company

  layout :visitors_layout

  def index
    render_404 unless @company
    redirect_to suspended_company_path(@company) and return unless @company.try(:active)

    if @company.sms.action.eql?('ident') || @company.sms.action.eql?('ident_auth')
      device = @company.devices.find_by_mac(session[:mac])
      return redirect_to sms_auth_path unless device
      return unless @company.sms.action.eql?('ident') && @company.sms.adv
      render 'widgets/sms/adv'
    end
  end

  private

  def visitors_layout
    case @company.layout
    when 'visitors_bg' then 'visitors_bg'
    else 'visitors'
    end
  end

  def save_params
    return unless params[:hs] && params[:hs][:mac_esc]

    session[:company_token] = params[:hs][:token]
    session[:link] = params[:hs][:link_login_only]
    session[:dst] = params[:hs][:dst]
    session[:mac] = mac_address(params[:hs][:mac_esc])
  end

  def load_company
    @company = Company.find_by_token(session[:company_token])
  end
end
