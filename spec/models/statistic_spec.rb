describe Statistic, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:company) }
  end
end
