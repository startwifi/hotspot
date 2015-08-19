class Company < ActiveRecord::Base
  has_many :users
  has_many :admins

  validates :name, :token, presence: true
end
