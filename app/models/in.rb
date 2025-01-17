class In < ApplicationRecord
  mount_uploader :post_image, InUploader

  validates :company, :group_name, presence: true

  belongs_to :company
end
