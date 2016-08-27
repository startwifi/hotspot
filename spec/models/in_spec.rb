RSpec.describe In, type: :model do
  describe 'validation' do
    it { should validate_presence_of :company }
    it { should validate_presence_of :group_name }
  end

  describe 'associations' do
    it { should belong_to :company }
  end
end
