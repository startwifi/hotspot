require 'rails_helper'

RSpec.describe Tw, type: :model do
  it { should validate_presence_of :company }
  it { should validate_presence_of :post_text }
  it { should belong_to :company }
end
