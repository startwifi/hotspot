class Event < ApplicationRecord
  belongs_to :user
  belongs_to :company

  scope :today, ->{ where('created_at >= ?', Time.zone.now.beginning_of_day) }
  scope :month, ->{ where('created_at >= ?', Time.zone.now.beginning_of_month) }
  scope :by_month, ->(month){ where('EXTRACT(MONTH FROM created_at) = ?', month) }
  scope :by_date, ->(date){ where('created_at::date = ?', date.to_date) }
  scope :social_count, ->(social){ where('provider = ?', social).count }
  scope :last25, -> { order('created_at desc').limit(25) }
end
