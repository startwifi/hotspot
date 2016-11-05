describe Tw, type: :model do
  describe 'associations' do
    it { should belong_to(:company) }
  end

  describe 'validation' do
    it { should validate_presence_of(:group_name) }
    it { should validate_presence_of(:post_text) }
  end
end
