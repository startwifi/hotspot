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

RSpec.describe Company, type: :model do
  describe 'validation' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :owner_name }
    it { should validate_presence_of :phone }
    it { should validate_presence_of :address }
    it { should validate_inclusion_of(:sms_auth).in_array(Company::SMS_AUTH_TYPES) }
  end

  describe 'associations' do
    it { should have_many(:admins).dependent(:destroy) }
    it { should have_many(:users).dependent(:destroy) }
    it { should have_many(:events).dependent(:destroy) }
    it { should have_many(:statistics).dependent(:destroy) }
    it { should have_one(:vk).dependent(:destroy) }
    it { should have_one(:fb).dependent(:destroy) }
    it { should have_one(:tw).dependent(:destroy) }
    it { should have_one(:ok).dependent(:destroy) }
    it { should have_one(:in).dependent(:destroy) }
  end
end
