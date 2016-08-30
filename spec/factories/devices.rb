FactoryGirl.define do
  factory :device do
    user
    company
    mac { Faker::Internet.mac_address }
  end
end
