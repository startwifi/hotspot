require 'mtik'

class Mikrotik
  def initialize(host, user, passwd)
    @host, @user, @passwd = host, user, passwd
  end

  def connect
    @connect ||= MTik::Connection.new(host: @host, user: @user, pass: @passwd)
    rescue Errno::ETIMEDOUT, Errno::ENETUNREACH,
      Errno::EHOSTUNREACH => exception
  end

  def ping(address='google.com', count=1)
    connect.get_reply(
      '/ping',
      '=.proplist=host,time',
      "=address=#{address}",
      "=count=#{count}"
    )
  end

  def get_resources
    connect.get_reply(
      '/system/resource/print',
      '=.proplist=board-name,version,uptime,cpu-load,free-memory,free-hdd-space'
    )
  end

  def get_capsman_hosts(ssid)
    connect.get_reply(
      '/caps-man/registration-table/print',
      '=.proplist=mac-address,rx-signal,uptime,bytes',
      "?ssid=#{ssid}"
    )
  end

  def get_capsman_caps
    connect.get_reply(
      '/caps-man/remote-cap/print',
      '=.proplist=address,base-mac,board,version,identity,state'
    )
  end

  def get_hotspot_hosts
    connect.get_reply(
      '/ip/hotspot/host/print',
      '=.proplist=mac-address,address,server,uptime,idle-timeout,authorized'
    )
  end

  def get_hotspot_active
    connect.get_reply(
      '/ip/hotspot/active/print',
      '=.proplist=mac-address,address,server,user,uptime,session-time-left'
    )
  end

  def get_ip_connection(ip)
    connect.get_reply(
     '/ip/firewall/connection/print',
     '=.proplist=src-address,dst-address,reply-src-address,reply-dst-address,protocol,tcp-state,timeout,orig-bytes,repl-bytes',
     "?src-address=#{ip}"
    )
  end

  def get_active_ppp_users
    connect.get_reply(
      '/ppp/active/print',
      '=.proplist=name,address,uptime'
    )
  end

  def add_bridge(name, comment)
    connect.get_reply(
      '/interface/bridge/add',
      "=name=#{name}",
      '=arp=enabled',
      "=comment=#{comment}"
    )
  end

  def add_pool(name, range)
    connect.get_reply(
      '/ip/pool/add',
      "=name=#{name}",
      "=ranges=#{range}",
      '=next-pool=none'
    )
  end

  def add_address(address, interface, network, comment)
    connect.get_reply(
      '/ip/address/add',
      "=address=#{address}",
      "=interface=#{interface}",
      "=network=#{network}",
      "=comment=#{comment}"
    )
  end

  def add_network(address, gateway, comment)
    connect.get_reply(
      '/ip/dhcp-server/network/add',
      "=address=#{address}",
      "=gateway=#{gateway}",
      "=comment=#{comment}"
    )
  end

  def add_dhcp_server(name, interface, pool, lease_time)
    connect.get_reply(
      '/ip/dhcp-server/add',
      "=name=#{name}",
      "=interface=#{interface}",
      "=address-pool=#{pool}",
      "=lease-time=#{lease_time}",
      '=add-arp=yes',
      '=disabled=no'
    )
  end

  def add_nat(address, comment)
    connect.get_reply(
      '/ip/firewall/nat/add',
      '=action=masquerade',
      '=chain=srcnat',
      "=src-address=#{address}",
      "=comment=#{comment}"
    )
  end

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
      '=use-radius=no'
    )
  end

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

  def reset_html(server)
    connect.get_reply(
      '/ip/hotspot/reset-html',
      "#{server}"
    )
  end

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
