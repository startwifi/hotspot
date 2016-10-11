class InitRouterService
  def initialize(company)
    @token = company.token
    @hs_name = "#{@token}_hs"
    @local_name = "#{@token}_local"
    @comment = company.name
    @ssid = 'StartWiFi'

    # Company network
    @network = company.network
    @lease_time = @network.lease_time
    @local_range = "#{@network.local_range_begin}-#{@network.local_range_end}"
    @hs_range = "#{@network.hotspot_range_begin}-#{@network.hotspot_range_end}"
    @hs_address = @network.hotspot_address
    @hs_network = @network.hotspot_network
    @local_network = @network.local_network
    @hs_gateway = @network.hotspot_gateway
    @local_gateway = @network.local_gateway
    @net = @network.net
    @wifi_password = @network.wifi_password

    # Need from company
    @dns = Figaro.env.router_dns

    # Auth options
    @login_by = "cookie,http-chap,trial,mac-cookie"
    @auth_type = "wpa-psk,wpa2-psk,wpa-eap,wpa2-eap"
    @encryption = "aes-ccm,tkip"
  end

  def run
    configure_interface
    configure_pool
    configure_dhcp
    configure_hotspot
    configure_nat
    configure_ppp
    configure_capsman
    router.reset_html(@token)
  end

  private

  def configure_interface
    router.add_bridge(@token, @comment)
  end

  def configure_pool
    router.add_pool(@local_name, @local_range)
    router.add_pool(@hs_name, @hs_range)
    router.add_address(@hs_address, @token, @net, @comment)
  end

  def configure_dhcp
    router.add_network(@hs_network, @hs_gateway, @comment)
    router.add_dhcp_server(@token, @token, @hs_name, @lease_time)
  end

  def configure_hotspot
    router.add_hotspot_profile(@token, @hs_gateway, @dns, @token, @login_by, @lease_time, @lease_time, @lease_time, "default")
    router.add_hotspot_server(@token, @token, @hs_name, @token)
  end

  def configure_nat
    router.add_nat(@hs_network, @comment)
    router.add_nat(@local_network, @comment)
  end

  def configure_ppp
    router.add_ppp_profile(@token, @local_gateway, @hs_name, @comment)
  end

  def configure_capsman
    router.add_capsman_security(@token, @auth_type, @encryption, @wifi_password, @comment)
    router.add_capsman_config(@token, @ssid, @token, @token, "public", @comment)
  end

  def router
    @router ||= Mikrotik.new(
      Figaro.env.router_host,
      Figaro.env.router_user,
      Figaro.env.router_pass
    )
  end
end
