class OauthSubdomain
  def self.matches?(request)
    %w(oauth oauth.staging oauth.wifi).include?(request.subdomain)
  end
end
