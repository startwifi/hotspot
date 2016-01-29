# == Schema Information
#
# Table name: oks
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
#  index_oks_on_company_id  (company_id)
#
# Foreign Keys
#
#  fk_rails_7d3afcb681  (company_id => companies.id)
#

class Ok < ActiveRecord::Base
  mount_uploader :post_image, OkUploader

  validates :company, :group_name, presence: true

  belongs_to :company
end
