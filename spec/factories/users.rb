FactoryGirl.define do
  factory :user do
    name "Example User"
    provider "facebook"
    uid "12345678"
  end
end
