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
#  mac              :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
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

FactoryGirl.define do
  factory :statistic do
    user
    company
    provider "Facebook"
    platform "Mac"
    platform_version "10.11"
    browser "Safari"
    browser_version "10"
    mac { Faker::Internet.mac_address }
  end

end
