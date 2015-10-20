class Tw < ActiveRecord::Base
  mount_uploader :post_image, TwUploader

  belongs_to :company

  validates :company, :group_name, :post_text, presence: true
end
