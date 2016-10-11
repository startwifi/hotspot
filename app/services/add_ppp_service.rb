class AddPppUserService
  def initialize(router)
    @company = router.company
    @token = @company.token
    @hs_name = "#{@token}_hs"
    @comment = "#{router.name} mikrotik"

    @local_gateway = @company.network.local_gateway

    # Need to generate
    @user_address = router.login
    @user_password = router.password

    # Need from company
    @radio_mac = router.radio_mac
  end

  def run
    configure_ppp
    configure_capsman
  end

  private

  def configure_ppp
    router.add_ppp_user(@token, @user_password, @token, @local_gateway, @user_address, @comment)
  end

  def configure_capsman
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
