require 'rails_helper'

RSpec.describe Company, type: :model do
  it { should validate_presence_of :name }
  it { should have_many :admins }
  it { should have_many :users }
  it { should have_many(:events).through(:users) }
  it { should have_one :vk }
  it { should have_one :fb }
  it { should have_one :tw }
end
