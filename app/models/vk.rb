class Vk < ActiveRecord::Base
  mount_uploader :post_image, VkUploader

  validates :company, :group_id, :group_name, presence: true

  belongs_to :company
end
