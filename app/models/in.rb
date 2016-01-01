# == Schema Information
#
# Table name: ins
#
#  id            :integer          not null, primary key
#  company_id    :integer
#  group_id      :string
#  group_name    :string
#  action        :string
#  link_redirect :string
#  post_text     :string
#  post_link     :string
#  post_image    :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_ins_on_company_id  (company_id)
#
# Foreign Keys
#
#  fk_rails_e7dcb4e1d6  (company_id => companies.id)
#

class In < ActiveRecord::Base
  mount_uploader :post_image, InUploader

  validates :company, :group_name, presence: true

  belongs_to :company
end
