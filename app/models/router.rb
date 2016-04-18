# == Schema Information
#
# Table name: routers
#
#  id             :integer          not null, primary key
#  company_id     :integer
#  ip_address     :string           not null
#  name           :string
#  login          :string           not null
#  password       :string           not null
#  available      :boolean          default(FALSE)
#  last_pinged_at :datetime
#  created_at     :datetime
#  updated_at     :datetime
#
# Indexes
#
#  index_routers_on_company_id                 (company_id)
#  index_routers_on_ip_address_and_company_id  (ip_address,company_id) UNIQUE
#

class Router < ActiveRecord::Base
  belongs_to :company

  validates :ip_address, :login, :password, presence: true
  validates :ip_address, uniqueness: { scope: :company_id } 

  def ping
    self.last_pinged_at = Time.now
    MTik::Connection.new(host: ip_address, user: login, pass: password)
    self.available = true
  rescue Errno::ETIMEDOUT, Errno::ENETUNREACH, Errno::EHOSTUNREACH, MTik::Error => exception
    self.available = false
    self.errors[:ip_address] << exception.message
  end
end
