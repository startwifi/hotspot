class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :registerable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable,
         :validatable

  belongs_to :company

  def active_for_authentication?
    super && active?
  end
end
