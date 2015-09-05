class Fb < ActiveRecord::Base
  validates :company, :group_id, :group_name, presence: true

  belongs_to :company
end
