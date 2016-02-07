require 'mtik'
class Mikrotik
  def initialize(host, user, passwd)
    @host, @user, @passwd = host, user, passwd
  end
  #Connect
  def connect
    @connect ||= MTik::Connection.new(host: @host, user: @user, pass: @passwd)
  end
  #Ping
  def ping(address="google.com", count)
    r = connect.get_reply(
      '/ping',
      "=address=#{address}",
      "=count=#{count}"
    )
    re = hand_response(r)
    return "#{re["host"]} ping: #{re["time"]}"
  end
  # Hand response
  def hand_response(response)
    response.each do |res|
      case res.first[0]
      when "!re"
        return res
      when "!done"
        return res.first[0]
      when "!trap"
        return res["message"]
      else
        return res
      end
    end
  end
  def get_resources()
    r = connect.get_reply(
      '/system/resource/print'
    )
    re = hand_response(r)
    return "#{re["platform"]}\n#{re["board-name"]}\nFirmware: #{re["version"]}\nUptime: #{re["uptime"]}
    Free HDD: #{re["free-hdd-space"].to_i/1024000.0} Mb\nFree RAM: #{re["free-memory"].to_i/1024000.0} Mb
    CPU freq: #{re["cpu-frequency"]}MHz\nCPU load: #{re["cpu-load"]}%\nCPU core: #{re["cpu-count"]}\n"
  end
  #add Bridge
  def add_bridge(name, comment)
    connect.get_reply(
      '/interface/bridge/add',
      "=name=#{name}",
      '=arp=enabled',
      "=comment=#{comment}"
    )
  end
  #add Pool
  def add_pool(name, range)
    connect.get_reply(
      '/ip/pool/add',
      "=name=#{name}",
      "=ranges=#{range}",
      '=next-pool=none'
    )
  end
  #add Address
  def add_address(address, interface, network, comment)
    connect.get_reply(
      '/ip/address/add',
      "=address=#{address}",
      "=interface=#{interface}",
      "=network=#{network}",
      "=comment=#{comment}"
    )
  end
  #add Network
  def add_network(address, gateway, comment)
    connect.get_reply(
      '/ip/dhcp-server/network/add',
      "=address=#{address}",
      "=gateway=#{gateway}",
      "=comment=#{comment}"
    )
  end
  #add DHCP Server
  def add_dhcp_server(name, interface, pool, lease_time)
    connect.get_reply(
      '/ip/dhcp-server/add',
      "=name=#{name}",
      "=interface=#{interface}",
      "=address-pool=#{pool}",
      "=lease-time=#{lease_time}",
      "=add-arp=yes",
      "=disabled=no"
    )
  end
  #add NAT
  def add_nat(address, comment)
    connect.get_reply(
      '/ip/firewall/nat/add',
      "=action=masquerade",
      '=chain=srcnat',
      "=src-address=#{address}",
      "=comment=#{comment}"
    )
  end
  #add PPP Profile
  def add_ppp_profile(name, local_address, remote_address, comment)
    connect.get_reply(
      '/ppp/profile/add',
      "=name=#{name}",
      "=local-address=#{local_address}",
      "=remote-address=#{remote_address}",
      '=only-one=default',
      "=comment=#{comment}"
    )
  end
  #add PPP User
  def add_ppp_user(name, password, profile, local_address, remote_address, comment)
    connect.get_reply(
      '/ppp/secret/add',
      "=name=#{name}",
      "=password=#{password}",
      '=service=any',
      "=profile=#{profile}",
      "=local-address=#{local_address}",
      "=remote-address=#{remote_address}",
      "=comment=#{comment}"
    )
  end
  #add HotSpot Profile
  def add_hotspot_profile(name, hs_address, dns, directory, login_by, cookie_time, trial_uptime, trial_reset, trial_profile)
    connect.get_reply(
      '/ip/hotspot/profile/add',
      "=name=#{name}",
      "=hotspot-address=#{hs_address}",
      "=dns-name=#{dns}",
      "=html-directory=#{directory}",
      "=login-by=#{login_by}",
      "=http-cookie-lifetime=#{cookie_time}",
      '=split-user-domain=no',
      "=trial-uptime-limit=#{trial_uptime}",
      "=trial-uptime-reset=#{trial_reset}",
      "=trial-user-profile=#{trial_profile}",
      "=use-radius=no"
    )
  end
  #add HotSpot Server
  def add_hotspot_server(interface, name, pool, profile)
    connect.get_reply(
      '/ip/hotspot/add',
      "=interface=#{interface}",
      "=name=#{name}",
      "=address-pool=#{pool}",
      "=profile=#{profile}",
      '=disabled=no'
    )
  end
  #reset HTML
  def reset_html(server)
    connect.get_reply(
      '/ip/hotspot/reset-html',
      "#{server}"
    )
  end
  #add CAPsMAN Security
  def add_capsman_security(name, auth_type, encryption, passphrase, comment)
    connect.get_reply(
      '/caps-man/security/add',
      "=name=#{name}",
      "=authentication-types=#{auth_type}",
      "=encryption=#{encryption}",
      "=passphrase=#{passphrase}",
      "=comment=#{comment}"
    )    
  end
  #add CAPsMAN Config
  def add_capsman_config(name, ssid, security, bridge, channel, comment)
    connect.get_reply(
      '/caps-man/configuration/add',
      "=name=#{name}",
      '=mode=ap',
      "=ssid=#{ssid}",
      '=tx-chains=0,1,2',
      '=rx-chains=0,1,2',
      "=security=#{security}",
      '=datapath.client-to-client-forwarding=yes',
      "=datapath.bridge=#{bridge}",
      "=channel=#{channel}",
      "=comment=#{comment}"
    )
  end
  #add CAPsMAN Server
  def add_capsman_server(radio_mac, config, comment)
    connect.get_reply(
      '/caps-man/provisioning/add',
      "=radio-mac=#{radio_mac}",
      '=action=create-dynamic-enabled',
      "=master-configuration=#{config}",
      '=name-format=identity',
      "=comment=#{comment}",
      '=disabled=no'
    )
  end
end