class OauthSubdomain
  def self.matches?(request)
    %w(oauth oauth.staging).include?(request.subdomain)
  end
end
