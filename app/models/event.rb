class Event < ActiveRecord::Base
  belongs_to :user

  scope :today, ->{ select('*').joins(:user).where('events.created_at >= ?', Time.zone.now.beginning_of_day) }
  scope :month, ->{ select('*').joins(:user).where('events.created_at >= ?', Time.zone.now.beginning_of_month) }
  scope :social_count, ->(social){ where('users.provider = ?', social).count }
  scope :by_date, ->(date){ where('events.created_at::date = ?', date.to_date) }
end
