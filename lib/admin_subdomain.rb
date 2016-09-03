class AdminSubdomain
  def self.matches?(request)
    %w(cp cp.staging).include?(request.subdomain)
  end
end
