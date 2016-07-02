# == Schema Information
#
# Table name: companies
#
#  id                     :integer          not null, primary key
#  name                   :string
#  token                  :string
#  phone                  :string
#  address                :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  owner_name             :string
#  cover                  :string
#  card                   :string
#  tos                    :boolean          default(FALSE)
#  tos_text               :text
#  active                 :boolean          default(TRUE)
#  sms_auth               :string           default("disabled")
#  sms_auth_link_redirect :string
#  layout                 :string
#

class Company < ActiveRecord::Base
  mount_uploader :cover, CoverUploader
  mount_uploader :card,  CardUploader

  has_secure_token

  SMS_AUTH_TYPES = %w(disabled normal preauth preauth_normal)

  has_many :users, dependent: :destroy
  has_many :admins, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :statistics, dependent: :destroy
  has_many :routers, dependent: :destroy
  has_many :devices, dependent: :destroy
  has_one :vk, dependent: :destroy
  has_one :fb, dependent: :destroy
  has_one :tw, dependent: :destroy
  has_one :in, dependent: :destroy
  has_one :ok, dependent: :destroy
  has_one :sms, dependent: :destroy

  validates :name, :owner_name, :phone, :address, presence: true
  validates :sms_auth, inclusion: { in: SMS_AUTH_TYPES }

  def create_dummy_social(*socials)
    socials.each do |social|
      send("create_#{social}!",
        group_name: get_group_name(social),
        action: 'disabled',
        link_redirect: ENV['LINK_REDIRECT'],
        post_text: self.name,
        post_link: get_group_link(social),
        post_image: Rails.root.join('app/assets/images/startwifi.png').open)
    end
  end

  def get_group_name(social)
    case social
    when :fb then ENV['FB_GROUP_NAME']
    when :vk then ENV['VK_GROUP_NAME']
    when :tw then ENV['TW_GROUP_NAME']
    when :in then ENV['IN_GROUP_NAME']
    when :ok then ENV['OK_GROUP_NAME']
    end
  end

  def get_group_link(social)
    case social
    when :fb then "https://facebook.com/" + ENV['FB_GROUP_NAME']
    when :vk then "https://vk.com/" + ENV['VK_GROUP_NAME']
    when :tw then "https://twitter.com/" + ENV['TW_GROUP_NAME']
    when :in then "https://instagram.com/" + ENV['IN_GROUP_NAME']
    when :ok then "http://ok.ru/group/" + ENV['OK_GROUP_NAME']
    end
  end

  def sms
    super || ensure_sms_settings
  end

  private

  def ensure_sms_settings
    create_sms(
      action: 'disabled',
      link_redirect: ENV['LINK_REDIRECT'],
      wall_head: 'StartWifi',
      wall_image: Rails.root.join('app/assets/images/startwifi.png').open
    )
  end
end
