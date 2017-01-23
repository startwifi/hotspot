class Device < ApplicationRecord
  belongs_to :company
  belongs_to :user, touch: true
  has_many :statistics, foreign_key: :mac, primary_key: :mac
  has_many :providers, -> { uniq }, through: :statistics, source: :user

  def events
    providers.collect(&:events).flatten
  end
end
