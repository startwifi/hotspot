# == Schema Information
#
# Table name: statistics
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  company_id       :integer
#  provider         :string
#  platform         :string
#  platform_version :string
#  browser          :string
#  browser_version  :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  mac              :macaddr
#
# Indexes
#
#  index_statistics_on_company_id  (company_id)
#  index_statistics_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_42a876aeed  (user_id => users.id)
#  fk_rails_b22b0254cf  (company_id => companies.id)
#

class Statistic < ActiveRecord::Base
  belongs_to :user
  belongs_to :company
end
