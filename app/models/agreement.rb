class Agreement < ApplicationRecord
  validates :type, :agreement_text, :language, presence: true
  validates :type, uniqueness: { scope: :language, message: 'should be one language of each type' }
end
