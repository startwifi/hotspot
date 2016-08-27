class Sms < ActiveRecord::Base
  mount_uploader :wall_image, SmsUploader

  belongs_to :company

  validates :company, presence: true
end
