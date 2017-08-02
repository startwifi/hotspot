class Router < ActiveRecord::Base

  belongs_to :company

  validates :ip_address, :login, :password, presence: true
  validates :ip_address, uniqueness: { scope: :company_id }

  def ping
    connection.ping
  end

  def resources
    connection.get_resources
  end

  def users
    connection.get_capsman_hosts('#!StartWiFi')
  end

  def connection
    @router ||= Mikrotik.new(
      ip_address,
      login,
      password
    )
  end
end
