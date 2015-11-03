FactoryGirl.define do
  factory :admin do
    email { Faker::Internet.free_email }
    password "password42"
    password_confirmation "password42"
    company
  end

end
