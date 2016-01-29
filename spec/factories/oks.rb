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

FactoryGirl.define do
  factory :ok do
    company
    group_id ""
    group_name { Faker::Lorem.word }
    action "auth"
    link_redirect { Faker::Internet.domain_name }
    post_text { Faker::Lorem.sentence }
    post_link { Faker::Internet.url }

    factory :ok_with_image do
      post_image { Rack::Test::UploadedFile.new("#{Rails.root}/spec/support/uploads/startwifi.png", 'image/png') }
    end
  end

end
