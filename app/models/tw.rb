# == Schema Information
#
# Table name: tws
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
#  index_tws_on_company_id  (company_id)
#
# Foreign Keys
#
#  fk_rails_e685a14d92  (company_id => companies.id)
#

class Tw < ActiveRecord::Base
  mount_uploader :post_image, TwUploader

  belongs_to :company

  validates :group_name, :post_text, presence: true
end
