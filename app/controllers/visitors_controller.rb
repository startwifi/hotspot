class VisitorsController < ApplicationController
  before_action :save_params
  before_action :load_company
  before_action :load_router

  layout :visitors_layout

  def index
    return render_404 unless @company && @router
    redirect_to suspended_company_path(@company) and return unless @company.try(:active)

    if @company.sms.action.eql?('ident') || @company.sms.action.eql?('ident_auth')
      device = @company.devices.find_by_mac(session[:mac])
      return redirect_to sms_authorize_path unless device
      return unless @company.sms.action.eql?('ident') && @company.sms.adv
      render 'widgets/sms/adv'
    end
  end

  def auth_by_password
    if @company && @company.guest.password_digest && @company.guest.authenticate(params[:password])
      redirect_to event_auth_path(:guest_password)
    else
      flash[:alert] = t('.error')
      redirect_to auth_path
    end
  end

  private

  def visitors_layout
    return unless @company
    @company.layout.eql?('visitors_bg') ? 'visitors_bg' : 'visitors'
  end

  def save_params
    return unless params[:hs] && params[:hs][:mac_esc] && params[:hs][:router]

    session[:company_token] = params[:hs][:token]
    session[:router_token] = params[:hs][:router]
    session[:router_identity] = params[:hs][:identity]
    session[:link] = params[:hs][:link_login_only]
    session[:dst] = params[:hs][:dst]
    session[:mac] = mac_address(params[:hs][:mac_esc])
    session[:ip] = params[:hs][:ip_esc]
  end

  def load_company
    @company = Company.find_by_token(session[:company_token])
  end

  def load_router
    @router = Router.find_by_token(session[:router_token])
  end
end
