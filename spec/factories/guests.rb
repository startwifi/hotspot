FactoryGirl.define do
  factory :guest do
    company nil
    action "auth"
    link_redirect { Faker::Internet.domain_name }
    wall_head { Faker::Lorem.word }
    wall_text { Faker::Lorem.sentence }
    adv false
    password_digest "MyString"

    factory :guest_with_image do
      wall_image { Rack::Test::UploadedFile.new("#{Rails.root}/spec/support/uploads/startwifi.png", 'image/png') }
    end
  end
end
