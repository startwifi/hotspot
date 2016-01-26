# == Schema Information
#
# Table name: vks
#
#  id            :integer          not null, primary key
#  company_id    :integer
#  group_id      :string
#  group_name    :string
#  action        :string
#  link_redirect :string
#  post_text     :text
#  post_link     :string
#  post_image    :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_vks_on_company_id  (company_id)
#
# Foreign Keys
#
#  fk_rails_2ec6abe442  (company_id => companies.id)
#

class Vk < ActiveRecord::Base
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
