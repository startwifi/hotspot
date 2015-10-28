FactoryGirl.define do
  factory :in do
    company
    group_id ""
    group_name { Faker::Lorem.word }
    action "auth"
    link_redirect { Faker::Internet.domain_name }
    post_text { Faker::Lorem.sentence }
    post_link { Faker::Internet.url }
    post_image { Rack::Test::UploadedFile.new("#{Rails.root}/spec/support/uploads/startwifi.png", 'image/png') }
  end

end
