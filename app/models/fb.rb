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

class Fb < ActiveRecord::Base
  mount_uploader :post_image, FbUploader

  validates :company, :group_id, :group_name, presence: true

  belongs_to :company

  before_validation :get_group_id

  def get_group_id
    begin
      oauth = Koala::Facebook::OAuth.new(Figaro.env.facebook_key,
                                         Figaro.env.facebook_secret)
      graph = Koala::Facebook::API.new(oauth.get_app_access_token)
      self.group_id = graph.get_object(self.group_name)['id']
    rescue
      nil
    end
  end
end
