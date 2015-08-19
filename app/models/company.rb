class Company < ActiveRecord::Base
  has_many :users
  has_many :admins
  has_many :events, through: :users

  validates :name, :token, presence: true
end
