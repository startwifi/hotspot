class AddPppUserService
  def initialize(router)
    @company = router.company
    @token = @company.token
    @hs_name = "#{@token}_hs"
    @comment = "#{router.name} mikrotik"
    @ssid = router.ssid

    @local_gateway = @company.network.local_gateway

    # Need to generate
    @user_address = router.login
    @user_password = router.password

    # Need from company
    @radio_mac = router.radio_mac

    # Auth options
    @auth_type = "wpa-psk,wpa2-psk,wpa-eap,wpa2-eap"
    @encryption = "aes-ccm,tkip"
  end

  def run
    configure_ppp
    configure_capsman
  end

  private

  def configure_ppp
    router.add_ppp_profile(@token, @local_gateway, @hs_name, @comment)
    router.add_ppp_user(@token, @user_password, @token, @local_gateway, @user_address, @comment)
  end

  def configure_capsman
    router.add_capsman_security(@token, @auth_type, @encryption, @user_password, @comment)
    router.add_capsman_config(@token, @ssid, @token, @token, "public", @comment)
    router.add_capsman_server(@radio_mac, @token, @comment)
  end

  def router
    @router ||= Mikrotik.new(
      Figaro.env.router_host,
      Figaro.env.router_user,
      Figaro.env.router_pass
    )
  end
end
