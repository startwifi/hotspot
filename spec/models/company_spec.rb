RSpec.describe Company, type: :model do
  describe 'validation' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :owner_name }
    it { should validate_presence_of :phone }
    it { should validate_presence_of :address }
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
