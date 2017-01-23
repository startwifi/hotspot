class Guest < ApplicationRecord
  mount_uploader :wall_image, GuestUploader

  has_secure_password(validations: false)

  belongs_to :company

  validates :company, presence: true
  validates :password, length: { minimum: 6 }, allow_blank: true
end
