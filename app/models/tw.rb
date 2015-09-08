class Tw < ActiveRecord::Base
  mount_uploader :post_image, TwUploader

  belongs_to :company

  validates :company, :post_text, presence: true
end
