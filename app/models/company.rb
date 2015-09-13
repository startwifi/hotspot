class Company < ActiveRecord::Base
  has_secure_token

  has_many :users, dependent: :destroy
  has_many :admins, dependent: :destroy
  has_many :events, through: :users, dependent: :destroy
  has_one :vk, dependent: :destroy
  has_one :fb, dependent: :destroy
  has_one :tw, dependent: :destroy

  validates :name, :owner_name, :phone, :address, presence: true
end
