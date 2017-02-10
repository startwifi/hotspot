require 'omniauth-guest'
require 'omniauth-sms'

OmniAuth.configure do |config|
  config.logger = Rails.logger
  config.path_prefix = nil
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook,
    setup: true,
    scope: 'public_profile,user_birthday,user_likes,publish_actions,email',
    info_fields: 'birthday,name,link,gender,email'
  provider :vkontakte,
    setup: true,
    scope: 'email,photos'
  provider :twitter,
    setup: true
  provider :instagram,
    setup: true,
    scope: 'likes comments relationships'
  provider :odnoklassniki,
    setup: true,
    response_type: 'code'
  provider :sms,
    smsauth_url: '/sms/auth',
    uid_field: 'otp_phone'
  provider :guest
end
