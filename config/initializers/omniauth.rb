require 'omniauth-guest'
require 'omniauth-sms'

OmniAuth.configure do |config|
  config.logger = Rails.logger
  config.path_prefix = nil
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook,
    Figaro.env.facebook_key,
    Figaro.env.facebook_secret,
    scope: 'public_profile,user_birthday,user_likes,publish_actions,email',
    info_fields: 'birthday,name,link,gender,email'
  provider :vkontakte,
    Figaro.env.vk_key,
    Figaro.env.vk_secret,
    scope: 'email,photos'
  provider :twitter,
    Figaro.env.twitter_key,
    Figaro.env.twitter_secret
  provider :instagram,
    Figaro.env.instagram_key,
    Figaro.env.instagram_secret,
    scope: 'likes comments relationships'
  provider :odnoklassniki,
    Figaro.env.ok_key,
    Figaro.env.ok_secret,
    public_key: Figaro.env.ok_public,
    response_type: 'code',
    redirect_uri: "http://hotspot.192.168.88.15.xip.io/auth/odnoklassniki/callback"
  provider :sms,
    smsauth_url: '/sms/auth',
    uid_field: 'otp_phone'
  provider :guest
end
