require 'smsc_api'

class SmsSender
  include ActiveModel::Model

  attr_accessor :phone

  validates_plausible_phone :phone, presence: true, with: /\A\+\d+/

  def send_sms(code)
    sms = SMSC.new()
    ret = sms.send_sms(phone, "Ваш пароль: #{code}", 1)

    ret
  end

end
