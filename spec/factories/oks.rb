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
