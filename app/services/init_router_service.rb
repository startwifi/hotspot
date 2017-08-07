class InitRouterService
  def initialize(company)
    @mk = company.routers.last
    @token = @mk.token
    @comment = company.token

    # Company router


    # Company network
    #@network = company.network
    @trial_uptime = "12h"#@network.lease_time
    @range = "192.168.82.10-192.168.82.210"#"#{@network.hotspot_range_begin}-#{@network.hotspot_range_end}"
    @address = "192.168.82.1/24"#@network.hotspot_address
    @network = "192.168.82.0/24"#@network.hotspot_network
    @gateway = "192.168.82.1"#@network.hotspot_gateway

    # Need from company
    @net = "192.168.82.0"#Figaro.env.router_net
    @dns = "auth.startwifi.me"#Figaro.env.router_dns

    # Auth options
    @login_by = "cookie,http-chap,trial,mac-cookie"
  end

  def run
    configure_interface
    configure_pool
    configure_dhcp
    configure_hotspot
    configure_nat
    router.reset_html(@token)
    #router.fetch_login_page(@token, @comment)
  end

  private

  def configure_interface
    router.add_bridge(@token, @comment)
  end

  def configure_pool
    router.add_pool(@token, @range)
    router.add_address(@address, @token, @net, @comment)
  end

  def configure_dhcp
    router.add_network(@network, @gateway, @comment)
    router.add_dhcp_server(@token, @trial_uptime)
  end

  def configure_hotspot
    router.add_hotspot_user_profile(@token, @trial_uptime)
    router.add_hotspot_profile(@token, @gateway, @dns, @login_by, @trial_uptime)
    router.add_hotspot_server(@token)
  end

  def configure_nat
    router.add_nat(@network, @comment)
    router.add_connection_mark(@token, @comment)
  end

  def router
    @router ||= Mikrotik.new(
      @mk.ip_address,
      @mk.login,
      @mk.password
    )
  end
end
