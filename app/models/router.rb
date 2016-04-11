class Router < ActiveRecord::Base
  belongs_to :company

  validates :ip_address, :login, :password, presence: true
  validates :ip_address, uniqueness: { scope: :company_id }

  def online?
    available?
  end

  def ping
    self.last_pinged_at = Time.now
    MTik::Connection.new(host: ip_address, user: login, pass: password)
    self.available = true
  rescue Errno::ETIMEDOUT, Errno::ENETUNREACH, Errno::EHOSTUNREACH, MTik::Error => exception
    self.available = false
    self.errors[:ip_address] << exception.message
  end
end
