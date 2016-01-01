# == Schema Information
#
# Table name: oks
#
#  id            :integer          not null, primary key
#  company_id    :integer
#  group_id      :string
#  group_name    :string
#  action        :string
#  link_redirect :string
#  post_text     :string
#  post_link     :string
#  post_image    :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_oks_on_company_id  (company_id)
#
# Foreign Keys
#
#  fk_rails_7d3afcb681  (company_id => companies.id)
#

RSpec.describe Ok, type: :model do
  describe 'validation' do
    it { should validate_presence_of :company }
    it { should validate_presence_of :group_name }
  end

  describe 'associations' do
    it { should belong_to :company }
  end
end
