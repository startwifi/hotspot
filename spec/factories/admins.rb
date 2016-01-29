# == Schema Information
#
# Table name: admins
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  company_id             :integer
#  admin                  :boolean
#
# Indexes
#
#  index_admins_on_company_id            (company_id)
#  index_admins_on_email                 (email) UNIQUE
#  index_admins_on_reset_password_token  (reset_password_token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_e493fcc5fa  (company_id => companies.id)
#

FactoryGirl.define do
  factory :admin do
    email { Faker::Internet.free_email }
    password "password42"
    password_confirmation "password42"
    company
  end

end
