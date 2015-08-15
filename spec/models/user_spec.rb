require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :provider }
    it { should validate_presence_of :uid }
  end

  describe 'attributes' do
    let(:user) { create(:user) }

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

end
