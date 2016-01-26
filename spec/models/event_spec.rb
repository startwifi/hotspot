# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  action     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  provider   :string
#  company_id :integer
#
# Indexes
#
#  index_events_on_company_id  (company_id)
#  index_events_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_0cb5590091  (user_id => users.id)
#  fk_rails_88786fdf2d  (company_id => companies.id)
#

RSpec.describe Event, type: :model do
  describe 'association' do
    it { should belong_to :user }
    it { should belong_to :company }
  end
end
