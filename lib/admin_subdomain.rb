class AdminSubdomain
  def self.matches?(request)
    %w(cp cp.staging cp.wifi).include?(request.subdomain)
  end
end
