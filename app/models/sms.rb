class Sms < ApplicationRecord
  mount_uploader :wall_image, SmsUploader

  belongs_to :company

  validates :company, presence: true
end
