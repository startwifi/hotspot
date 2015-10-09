class Company < ActiveRecord::Base
  mount_uploader :cover, CoverUploader
  mount_uploader :card,  CardUploader

  has_secure_token

  has_many :users, dependent: :destroy
  has_many :admins, dependent: :destroy
  has_many :events, dependent: :destroy
  has_one :vk, dependent: :destroy
  has_one :fb, dependent: :destroy
  has_one :tw, dependent: :destroy

  validates :name, :owner_name, :phone, :address, presence: true

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
    end
  end

  def get_group_link(social)
    case social
    when :fb then "https://facebook.com/" + ENV['FB_GROUP_NAME']
    when :vk then "https://vk.com/" + ENV['VK_GROUP_NAME']
    when :tw then "https://twitter.com/" + ENV['TW_GROUP_NAME']
    end
  end
end
