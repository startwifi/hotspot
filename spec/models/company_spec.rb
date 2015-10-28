require 'rails_helper'

RSpec.describe Company, type: :model do
  it { should validate_presence_of :name }
  it { should have_many(:admins).dependent(:destroy) }
  it { should have_many(:users).dependent(:destroy) }
  it { should have_many(:events).dependent(:destroy) }
  it { should have_one(:vk).dependent(:destroy) }
  it { should have_one(:fb).dependent(:destroy) }
  it { should have_one(:tw).dependent(:destroy) }
  it { should have_one(:ok).dependent(:destroy) }
end
