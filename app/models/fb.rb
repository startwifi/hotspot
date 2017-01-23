class Fb < ApplicationRecord
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
