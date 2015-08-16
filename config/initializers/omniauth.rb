OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook,
    Rails.application.secrets.facebook_key,
    Rails.application.secrets.facebook_secret
  provider :vkontakte,
    Rails.application.secrets.vk_key,
    Rails.application.secrets.vk_secret
  provider :twitter,
    Rails.application.secrets.twitter_key,
    Rails.application.secrets.twitter_secret
end

