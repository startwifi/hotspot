require 'rails_helper'

RSpec.describe Vk, type: :model do
  it { should validate_presence_of :company }
  it { should validate_presence_of :group_id }
  it { should validate_presence_of :group_name }
  it { should belong_to :company }
end
