OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook,
    Rails.application.secrets.facebook_key,
    Rails.application.secrets.facebook_secret,
    scope: 'public_profile,user_birthday,user_likes,publish_actions,email',
    info_fields: 'birthday,name,link,gender,email'
  provider :vkontakte,
    Rails.application.secrets.vk_key,
    Rails.application.secrets.vk_secret,
    scope: 'email'
  provider :twitter,
    Rails.application.secrets.twitter_key,
    Rails.application.secrets.twitter_secret
  provider :odnoklassniki,
    Rails.application.secrets.ok_key,
    Rails.application.secrets.ok_secret,
    public_key: Rails.application.secrets.ok_public,
    response_type: 'code',
    redirect_uri: "http://hotspot.192.168.88.15.xip.io/auth/odnoklassniki/callback"
end

