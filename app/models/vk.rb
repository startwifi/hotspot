class Vk < ApplicationRecord
  mount_uploader :post_image, VkUploader

  validates :company, :group_id, :group_name, presence: true

  belongs_to :company

  before_validation :get_group_id

  def get_group_id
    begin
      group = RestClient.post 'https://api.vk.com/method/groups.getById', { group_id: self.group_name }
      self.group_id = JSON.parse(group.body).first[1][0]['gid']
    rescue
      nil
    end
  end
end
