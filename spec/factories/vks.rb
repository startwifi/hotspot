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

FactoryGirl.define do
  factory :vk do
    company
    group_id "1234567890"
    group_name { Faker::Lorem.word }
    action "auth"
    link_redirect { Faker::Internet.domain_name }
    post_text { Faker::Lorem.sentence }
    post_link { Faker::Internet.url }

    factory :vk_with_image do
      post_image { Rack::Test::UploadedFile.new("#{Rails.root}/spec/support/uploads/startwifi.png", 'image/png') }
    end
  end

end
