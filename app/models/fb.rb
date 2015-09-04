class Fb < ActiveRecord::Base
  validates :company, :group_name, presence: true

  belongs_to :company
end
