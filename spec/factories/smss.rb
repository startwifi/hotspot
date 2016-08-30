FactoryGirl.define do
  factory :sms do
    company
    action 'ident'
    link_redirect { Faker::Internet.domain_name }
    wall_head { Faker::Lorem.word }
    wall_text { Faker::Lorem.sentence }
    adv false

    factory :sms_with_image do
      wall_image { Rack::Test::UploadedFile.new("#{Rails.root}/spec/support/uploads/startwifi.png", 'image/png') }
    end
  end
end
