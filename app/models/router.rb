class Router < ActiveRecord::Base
  CONNECTION_TIMEOUT_IN_SECONDS = 10

  belongs_to :company

  validates :ip_address, :login, :password, presence: true
  validates :ip_address, uniqueness: { scope: :company_id }

  def ping
    self.last_pinged_at = Time.now
    MTik::Connection.new(host: ip_address, user: login, pass: password, conn_timeout: CONNECTION_TIMEOUT_IN_SECONDS)
    self.available = true
  rescue Errno::ETIMEDOUT, Errno::ENETUNREACH, Errno::EHOSTUNREACH => exception
    self.available = false
    self.errors[:ip_address] << I18n.t('router.please_connect')
  rescue MTik::Error => exception
    self.available = false
    self.errors[:ip_address] << exception.message
  end
end
