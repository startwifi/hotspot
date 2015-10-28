FactoryGirl.define do
  factory :vk do
    company
    group_id "1234567890"
    group_name { Faker::Lorem.word }
    action "auth"
    link_redirect { Faker::Internet.domain_name }
    post_text { Faker::Lorem.sentence }
    post_link { Faker::Internet.url }
    post_image { Rack::Test::UploadedFile.new("#{Rails.root}/spec/support/uploads/startwifi.png", 'image/png') }
  end

end
