describe Device, type: :model do
  describe 'associations' do
    it { should belong_to :company }
    it { should have_many :statistics }
    it { should have_many :providers }
  end
end
