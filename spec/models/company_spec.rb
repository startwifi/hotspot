require 'rails_helper'

RSpec.describe Company, type: :model do
  it { should validate_presence_of :name }
  it { should validate_presence_of :token }
  it { should have_many :admins }
  it { should have_many :users }
  it { should have_many(:events).through(:users) }
  it { should have_one :vk }
end
