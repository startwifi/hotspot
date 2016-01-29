# == Schema Information
#
# Table name: fbs
#
#  id            :integer          not null, primary key
#  company_id    :integer
#  group_id      :string
#  group_name    :string
#  action        :string
#  link_redirect :string
#  post_text     :text
#  post_link     :string
#  post_image    :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_fbs_on_company_id  (company_id)
#
# Foreign Keys
#
#  fk_rails_828e6e9a7e  (company_id => companies.id)
#

RSpec.describe Fb, type: :model do
  describe 'validation' do
    it { should validate_presence_of :company }
    it { should validate_presence_of :group_id }
    it { should validate_presence_of :group_name }
  end

  describe 'associations' do
    it { should belong_to :company }
  end
end
