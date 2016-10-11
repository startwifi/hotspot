class CreateNetworkService
  def initialize(company)
    @company = company
  end

  def run
    create_company_network
  end

  private

  def create_company_network
    @company.create_network(
      local_network: local_network.to_string,
      local_range_begin: local_range_begin,
      local_range_end: local_range_end,
      local_gateway: local_network.first.to_s,
      hotspot_network: hotspot_network.to_string,
      hotspot_range_begin: hotspot_range_begin,
      hotspot_range_end: hotspot_range_end,
      hotspot_gateway: hotspot_network.first.to_s,
      hotspot_address: hotspot_network.first.to_string,
      net: hotspot_network.to_s,
      lease_time: 12,
      wifi_password: Network.generate_password
    )
  end

  def local_network
    ip = IPAddress(last_network.try(:local_network) || '192.168.5.0/24')
    ip[2] = ip[2].next
    @local_network ||= ip
  end

  def local_range_begin
    local_network[3] = 11
    local_network.to_s
  end

  def local_range_end
    local_network[3] = 210
    local_network.to_s
  end

  def hotspot_network
    ip = IPAddress(last_network.try(:hotspot_network) || '192.168.6.0/24')
    ip[2] = ip[2].next
    @hotspot_network ||= ip
  end

  def hotspot_range_begin
    hotspot_network[3] = 11
    hotspot_network.to_s
  end

  def hotspot_range_end
    hotspot_network[3] = 210
    hotspot_network.to_s
  end

  def last_network
    @network = Company.last.network
  end
end
