# == Schema Information
#
# Table name: sms
#
#  id            :integer          not null, primary key
#  company_id    :integer
#  action        :string
#  link_redirect :string
#  wall_head     :string
#  wall_text     :text
#  wall_image    :string
#  adv           :boolean          default(FALSE)
#
# Indexes
#
#  index_sms_on_company_id  (company_id)
#

class Sms < ActiveRecord::Base
  mount_uploader :wall_image, SmsUploader

  belongs_to :company

  validates :company, presence: true
end
