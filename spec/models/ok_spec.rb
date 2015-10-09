require 'rails_helper'

RSpec.describe Ok, type: :model do
  it { should validate_presence_of :company }
  it { should validate_presence_of :group_name }
  it { should belong_to :company }
end
