# == Schema Information
#
# Table name: sms
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
#  index_sms_on_company_id  (company_id)
#
# Foreign Keys
#
#  fk_rails_0ea7adfa4d  (company_id => companies.id)
#


# Sms auth model
class Sm < ActiveRecord::Base
  validates :company, presence: true

  belongs_to :company
end
