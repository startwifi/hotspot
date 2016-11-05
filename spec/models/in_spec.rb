describe In, type: :model do
  describe 'associations' do
    it { should belong_to(:company) }
  end

  describe 'validation' do
    it { should validate_presence_of(:company) }
    it { should validate_presence_of(:group_name) }
  end
end
