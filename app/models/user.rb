class User < ActiveRecord::Base
  belongs_to :company
  has_many :events, dependent: :destroy
  has_many :statistics, dependent: :destroy
  has_many :devices
  validates :name, :provider, :uid, :company, presence: true

  scope :birthdays, -> { where("extract(month from birthday) = ? AND
                               extract(day from birthday) >= ?",
                               Time.zone.today.strftime('%m'),
                               Time.zone.today.strftime('%d')) }

  def add_event(action)
    events.create!(action: action, provider: self.provider, company: self.company)
  end

  def macs
    statistics.collect(&:mac).compact.uniq
  end

  def self.to_csv
    attributes = %w(id name gender provider uid email birthday created_at updated_at)

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.find_each do |user|
        csv << attributes.map{ |attr| user.send(attr) }
      end
    end
  end
end
