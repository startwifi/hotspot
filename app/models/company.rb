class Company < ActiveRecord::Base
  mount_uploader :cover, CoverUploader
  mount_uploader :card,  CardUploader

  has_secure_token

  SMS_AUTH_TYPES = %w(disabled normal preauth preauth_normal).freeze

  has_many :users, dependent: :destroy
  has_many :admins, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :statistics, dependent: :destroy
  has_many :routers, dependent: :destroy
  has_many :devices, dependent: :destroy
  has_one :network, dependent: :destroy
  has_one :vk, dependent: :destroy
  has_one :fb, dependent: :destroy
  has_one :tw, dependent: :destroy
  has_one :in, dependent: :destroy
  has_one :ok, dependent: :destroy
  has_one :sms, dependent: :destroy

  validates :name, :owner_name, :phone, :address, presence: true
  validates :sms_auth, inclusion: { in: SMS_AUTH_TYPES }

  def sms
    super || ensure_sms_settings
  end

  def network
    super # || ensure_network
  end

  private

  def ensure_sms_settings
    create_sms(
      action: 'disabled',
      link_redirect: Figaro.env.link_redirect,
      wall_head: 'StartWifi',
      wall_image: Rails.root.join('app/assets/images/startwifi.png').open
    )
  end

  def ensure_network
    CreateNetworkService.new(self).run
  end
end
