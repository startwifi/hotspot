RSpec.describe Network, type: :model do
  describe 'validation' do
    it { should validate_presence_of :local_network }
    it { should validate_presence_of :local_range_begin }
    it { should validate_presence_of :local_range_end }
    it { should validate_presence_of :local_gateway }
    it { should validate_presence_of :hotspot_network }
    it { should validate_presence_of :hotspot_range_begin }
    it { should validate_presence_of :hotspot_range_end }
    it { should validate_presence_of :hotspot_gateway }
    it { should validate_presence_of :hotspot_address }
    it { should validate_presence_of :net }
    it { should validate_presence_of :lease_time }
  end

  describe 'associations' do
    it { should belong_to(:company) }
  end
end
