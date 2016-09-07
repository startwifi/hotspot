require 'rotp'

class Sms::AuthController < ApplicationController
  layout 'visitors'
  before_action :load_company

  def index
    @model = SmsSender.new
  end

  def send_sms
    @model = SmsSender.new(params[:sms_sender])

    if @model.validate
      session[:otp_secret] ||= ROTP::Base32.random_base32
      session[:otp_counter] ||= 0
      session[:otp_phone] = @model.phone

      # Start generate OTP password
      session[:otp_counter] += 1 # Increment counter

      hotp = ROTP::HOTP.new(session[:otp_secret])
      code = hotp.at(session[:otp_counter])

      @model.send_sms(code)
      redirect_to sms_auth_validate_path, notice: t('.success', phone: @model.phone)
    else
      render :index
    end
  end

  def validate
    if request.post?
      hotp = ROTP::HOTP.new(session[:otp_secret])

      if hotp.verify(params[:sms][:code], session[:otp_counter])
        if @company.sms.action.eql?('ident_auth') && session[:sms_auth_success].present?
          return redirect_to event_auth_path(:sms)
        end
        return redirect_to '/sms/callback'
      else
        redirect_to :back, alert: t('.errors')
      end
    end
  end

  private

  def load_company
    @company = Company.find_by_token(session[:company_token])
    if @company.nil? || @company.sms.action.eql?('disabled')
      redirect_to auth_path
    end
  end
end
