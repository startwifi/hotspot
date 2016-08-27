RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe 'validation' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :provider }
    it { should validate_presence_of :uid }
    it { should validate_presence_of :company }
  end

  describe 'association' do
    it { should belong_to :company }
    it { should have_many(:events).dependent(:destroy) }
  end

  describe 'attributes' do
    it { should respond_to :name }
    it { should respond_to :provider }
    it { should respond_to :uid }

    it "#name returns a string" do
      expect(user.name).to eq 'Example User'
    end

    it "#provider returns a string" do
      expect(user.provider).to eq 'facebook'
    end

    it "#uid returns a string" do
      expect(user.uid).to eq '12345678'
    end
  end

  describe '#add_event' do
    let(:first_event) { create(:event, user: user) }
    let(:second_event) { create(:event, user: user) }

    it 'adds event to user' do
      expect { user.add_event('logout') }.to change(Event, :count).by(1)
    end

    it 'returns array with events' do
      expect(user.events).to match_array [first_event, second_event]
    end
  end

  describe '.parse_vk_bdate' do
    it 'should return nil if bdate nil' do
      expect(User.parse_vk_bdate(nil)).to be_nil
    end

    it 'should return full date if persist' do
      expect(User.parse_vk_bdate('12.11.1988')).to match Date.new(1988, 11, 12)
    end

    it 'should return date with 1912 year if year is not present in bday' do
      expect(User.parse_vk_bdate('12.11')).to match Date.new(1912, 11, 12)
    end
  end
end
