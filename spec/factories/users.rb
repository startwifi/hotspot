# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string
#  provider   :string
#  uid        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  birthday   :date
#  url        :string
#  company_id :integer
#  email      :string
#  gender     :string
#
# Indexes
#
#  index_users_on_company_id  (company_id)
#
# Foreign Keys
#
#  fk_rails_7682a3bdfe  (company_id => companies.id)
#

FactoryGirl.define do
  factory :user do
    name "Example User"
    provider "facebook"
    uid "12345678"
    company
  end
end
