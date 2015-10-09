class Ok < ActiveRecord::Base
  mount_uploader :post_image, OkUploader

  validates :company, :group_name, presence: true

  belongs_to :company
end
