FactoryGirl.define do
  factory :admin do
    email "admin@example.com"
    password "password42"
    password_confirmation "password42"
    company
  end

end
