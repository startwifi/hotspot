# == Schema Information
#
# Table name: devices
#
#  id         :integer          not null, primary key
#  company_id :integer
#  mac        :macaddr
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  phone      :string
#  user_id    :integer
#
# Indexes
#
#  index_devices_on_company_id  (company_id)
#  index_devices_on_user_id     (user_id)
#

class Device < ActiveRecord::Base
  belongs_to :company
  belongs_to :user, touch: true
  has_many :statistics, foreign_key: :mac, primary_key: :mac
  has_many :providers, -> { uniq }, through: :statistics, source: :user
end
