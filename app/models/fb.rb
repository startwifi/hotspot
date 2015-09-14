class Fb < ActiveRecord::Base
  mount_uploader :post_image, FbUploader

  validates :company, :group_id, :group_name, presence: true

  belongs_to :company

  before_validation :get_group_id

  def get_group_id
    begin
      oauth = Koala::Facebook::OAuth.new(Rails.application.secrets.facebook_key,
                                         Rails.application.secrets.facebook_secret)
      graph = Koala::Facebook::API.new(oauth.get_app_access_token)
      self.group_id = graph.get_object(self.group_name)['id']
    rescue
      nil
    end
  end
end
