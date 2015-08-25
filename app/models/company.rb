class Company < ActiveRecord::Base
  has_secure_token

  has_many :users
  has_many :admins
  has_many :events, through: :users
  has_one :vk

  validates :name, :owner_name, :phone, :address, presence: true
end
