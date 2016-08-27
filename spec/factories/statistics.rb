FactoryGirl.define do
  factory :statistic do
    user
    company
    provider "Facebook"
    platform "Mac"
    platform_version "10.11"
    browser "Safari"
    browser_version "10"
    mac { Faker::Internet.mac_address }
  end

end
