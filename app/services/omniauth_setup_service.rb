class OmniauthSetupService
  def initialize(company, provider)
    @company = company
    @provider = provider
    @api = {}
  end

  def call
    prepare_credentials
    omniauth_credentials
  end

  private

  def omniauth_credentials
    case @provider
    when 'twitter'
      {
        consumer_key: @api[:key],
        consumer_secret: @api[:secret]
      }
    when 'odnoklassniki'
      {
        client_id: @api[:key],
        client_secret: @api[:secret],
        public_key: @api[:public],
        redirect_uri: Figaro.env.ok_redirect_uri
      }
    else
      {
        client_id: @api[:key],
        client_secret: @api[:secret],
      }
    end
  end

  def prepare_credentials
    case @provider
    when 'facebook'
      @api[:key] = @company.fb.api_key.present? ? @company.fb.api_key : Figaro.env.facebook_key
      @api[:secret] = @company.fb.api_secret.present? ? @company.fb.api_secret : Figaro.env.facebook_secret
    when 'vkontakte'
      @api[:key] = @company.vk.api_key.present? ? @company.vk.api_key : Figaro.env.vk_key
      @api[:secret] = @company.vk.api_secret.present? ? @company.vk.api_secret : Figaro.env.vk_secret
    when 'twitter'
      @api[:key] = @company.tw.api_key.present? ? @company.tw.api_key : Figaro.env.twitter_key
      @api[:secret] = @company.tw.api_secret.present? ? @company.tw.api_secret : Figaro.env.twitter_secret
    when 'instagram'
      @api[:key] = @company.in.api_key.present? ? @company.in.api_key : Figaro.env.instagram_key
      @api[:secret] = @company.in.api_secret.present? ? @company.in.api_secret : Figaro.env.instagram_secret
    when 'odnoklassniki'
      @api[:key] = @company.ok.api_key.present? ? @company.ok.api_key : Figaro.env.ok_key
      @api[:secret] = @company.ok.api_secret.present? ? @company.ok.api_secret : Figaro.env.ok_secret
      @api[:public] = @company.ok.api_public.present? ? @company.ok.api_public : Figaro.env.ok_public
    end
  end
end
