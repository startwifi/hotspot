# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  name       :string
#  token      :string
#  phone      :string
#  address    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  owner_name :string
#  cover      :string
#  card       :string
#

FactoryGirl.define do
  factory :company do
    name "Club Inc"
    owner_name "Cool owner"
    token "j4g2gs92sg3"
    phone "123 45 67"
    address "Dnz"
  end

end
