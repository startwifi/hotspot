require 'rotp'

class Sms::AuthController < ApplicationController
  layout 'visitors'

  def index
    @model = Sms.new
  end

  # def send
  # end
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
      redirect_to sms_auth_validate_path, flash: { notice: "На номер #{@model.phone} был выслан код подтверждения" }
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
        redirect_to :index, flash: { error: 'Вы ввели не правильной код подтверждения. Попробуйте снова' }
      end
    end
  end
end
