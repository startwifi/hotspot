# == Schema Information
#
# Table name: tws
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
#  index_tws_on_company_id  (company_id)
#
# Foreign Keys
#
#  fk_rails_e685a14d92  (company_id => companies.id)
#

RSpec.describe Tw, type: :model do
  describe 'validation' do
    it { should validate_presence_of :group_name }
    it { should validate_presence_of :post_text }
  end

  describe 'associations' do
    it { should belong_to :company }
  end
end
