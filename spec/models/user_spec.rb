require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :provider }
    it { should validate_presence_of :uid }
  end
end
