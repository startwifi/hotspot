require 'rotp'

class Sms::AuthController < ApplicationController
  layout 'visitors'
  before_action :load_company

  def index
    @model = Sms.new
  end

  def send_sms
    @model = Sms.new(params[:sms])

    if @model.validate
      session[:otp_secret] ||= ROTP::Base32.random_base32
      session[:otp_counter] ||= 0
      session[:otp_phone] = @model.phone

      # Start generate OTP password
      session[:otp_counter] += 1 # Increment counter

      hotp = ROTP::HOTP.new(session[:otp_secret])
      code = hotp.at(session[:otp_counter])

      ret = @model.send_sms(code)
      redirect_to sms_auth_validate_path, notice: t('.success', phone: @model.phone)
    else
      render :index
    end
  end

  def validate
    if request.post?
      hotp = ROTP::HOTP.new(session[:otp_secret])

      if hotp.verify(params[:sms][:code], session[:otp_counter])
        redirect_to '/auth/sms/callback'
      else
        redirect_to :back, alert: t('.errors')
      end
    end
  end

  private

  def load_company
    @company = Company.find_by_token(session[:company_token])
    if @company.nil? || @company.sms_auth.eql?('disabled') || user_signed_in?
      redirect_to auth_path
    end
  end
end
