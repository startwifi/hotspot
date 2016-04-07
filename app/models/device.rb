# == Schema Information
#
# Table name: devices
#
#  id         :integer          not null, primary key
#  company_id :integer
#  mac        :macaddr
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_devices_on_company_id  (company_id)
#

class Device < ActiveRecord::Base
  belongs_to :company
  has_many :statistics, foreign_key: :mac, primary_key: :mac
  has_many :providers, -> { uniq }, through: :statistics, source: :user
end
