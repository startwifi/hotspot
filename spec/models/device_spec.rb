require 'rails_helper'

RSpec.describe Device, type: :model do
  describe 'associations' do
    it { should belong_to :company }
    it { should have_many :statistics }
  end
end
