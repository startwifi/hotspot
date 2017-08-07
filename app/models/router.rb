class Router < ActiveRecord::Base

  belongs_to :company

  has_secure_token

  validates :ip_address, :login, :password, presence: true
  validates :ip_address, uniqueness: { scope: :company_id }

  def ping
    connection.ping
  end

  def resources
    connection.get_resources
  end

  def hotspot_servers
    hand(connection.get_hotspot_servers)
  end

  def hotspot_profiles(profile)
    hand(connection.get_hotspot_profiles(profile))
  end

  def l2tp_clients
    hand(connection.get_l2tp_clients)
  end

  def wifi_interfaces
    hand(connection.get_wifi_interfaces)
  end

  def wifi_users
    hand(connection.get_wifi_users)
  end

  def hand(response)
    hand_data = Array.new
    response.each do |res|
      case res.first[0]
      when "!re"
        hand_data.push(res)
      when "!trap"
        Rails.logger.info res["message"]
      end
    end
    return hand_data
  end

  def connection
    @router ||= Mikrotik.new(
      ip_address,
      login,
      password
    )
  end
end
