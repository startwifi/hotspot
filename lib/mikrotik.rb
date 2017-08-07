require 'mtik'

class Mikrotik
  def initialize(host, user, passwd)
    @host, @user, @passwd = host, user, passwd
  end

  def connect
    begin
       @connect ||= MTik::Connection.new(host: @host, user: @user, pass: @passwd, conn_timeout: 1)
    rescue Errno::ETIMEDOUT, Errno::ENETUNREACH,
      Errno::EHOSTUNREACH => exception
    end
  end

  def ping(address='google.com', count=1)
    connect ? connect.get_reply(
      '/ping',
      '=.proplist=host,time',
      "=address=#{address}",
      "=count=#{count}"
    ) : false
  end

  def get_resources
    connect ? connect.get_reply(
      '/system/resource/print',
      '=.proplist=board-name,version,uptime,cpu-load,free-memory,free-hdd-space'
    ) : false
  end

  def fetch_login_page(token, name)
    connect.get_reply(
      '/tool/fetch',
      "url=http://startwifi.me/#{name}/login.html",
      "dst-path=flash/#{token}/login.html"
    )
  end

  def get_identity
    connect.get_reply(
      '/system/identity/print'
    )
  end

  def get_bridge(name)
    connect.get_reply(
      '/interface/bridge/print',
      "?name=#{name}"
    )
  end

  def get_bridge_port(interface)
    connect.get_reply(
      '/interface/bridge/port/print',
      "?interface=#{interface}"
    )
  end

  def set_bridge_port(id, bridge)
    connect.get_reply(
      '/interface/bridge/port/set',
      "numbers=#{id}",
      "=bridge=#{bridge}"
    )
  end

  def get_pool(name)
    connect.get_reply(
      '/ip/pool/print',
      "?name=#{name}"
    )
  end

  def get_all_addresses
    connect.get_reply(
      '/ip/address/print'
    )
  end

  def get_address(name)
    connect.get_reply(
      '/ip/address/print',
      "?interface=#{name}"
    )
  end

  def get_dhcp_network(name)
    connect.get_reply(
      '/ip/dhcp-server/network/print',
      "?comment=#{name}"
    )
  end

  def get_dhcp_server(name)
    connect.get_reply(
      '/ip/dhcp-server/print',
      "?name=#{name}"
    )
  end

  def get_dhcp_lease(mac)
    connect.get_reply(
      '/ip/dhcp-server/lease/print',
      "?mac-address=#{mac}"
    )
  end

  def get_nat(name)
    connect.get_reply(
      '/ip/firewall/nat/print',
      "?comment=#{comment}"
    )
  end

  def get_hotspot_server_profile(name)
    connect.get_reply(
      '/ip/hotspot/profile/print',
      "?name=#{name}"
    )
  end

  def get_hotspot_user_profile(name)
    connect.get_reply(
      '/ip/hotspot/user/profile/print',
      "?name=#{name}"
    )
  end

  def get_hotspot_servers
    connect.get_reply(
      '/ip/hotspot/print',
      '=.proplist=name,interface,address-pool,profile,addresses-per-mac'
    )
  end

  def get_hotspot_server(name)
    connect.get_reply(
      '/ip/hotspot/print',
      "?name=#{name}"
    )
  end

  def get_wifi_interfaces
    connect.get_reply(
      '/interface/wireless/print',
      '=.proplist=name,interface-type,ssid,disabled,comment'
    )
  end

  def get_wifi_users
    connect.get_reply(
      '/interface/wireless/registration-table/print'
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

  def get_connection(mark)
    connect.get_reply(
     '/ip/firewall/connection/print',
     "?connection-mark=#{mark}"
    )
  end

  def get_l2tp_clients
    connect.get_reply(
      '/interface/l2tp-client/print'
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

  def add_dhcp_server(name, lease_time)
    connect.get_reply(
      '/ip/dhcp-server/add',
      "=name=#{name}",
      "=interface=#{name}",
      "=address-pool=#{name}",
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

  def add_connection_mark(interface, mark)
    connect.get_reply(
      '/ip/firewall/mangle/add',
      '=chain=forward',
      "=in-interface=#{interface}",
      'action=mark-connection',
      "=new-connection-mark=#{mark}",
      'passthrough=yes',
      "=comment=#{mark}"
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

  def add_hotspot_user_profile(name, trial_uptime)
    connect.get_reply(
      '/ip/hotspot/user/profile/add',
      "=name=#{name}",
      "=session-timeout=#{trial_uptime}",
      '=shared-users=2'
    )
  end

  def add_hotspot_profile(name, hs_address, dns, login_by, trial_uptime)
    connect.get_reply(
      '/ip/hotspot/profile/add',
      "=name=#{name}",
      "=hotspot-address=#{hs_address}",
      "=dns-name=#{dns}",
      "=html-directory=#{name}",
      "=login-by=#{login_by}",
      "=http-cookie-lifetime=#{trial_uptime}",
      '=split-user-domain=no',
      "=trial-uptime-limit=#{trial_uptime}",
      "=trial-uptime-reset=#{trial_uptime}",
      "=trial-user-profile=#{name}",
      '=use-radius=no'
    )
  end

  def add_hotspot_server(name)
    connect.get_reply(
      '/ip/hotspot/add',
      "=interface=#{name}",
      "=name=#{name}",
      "=address-pool=#{name}",
      "=profile=#{name}",
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
