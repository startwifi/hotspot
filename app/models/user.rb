# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string
#  provider   :string
#  uid        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  birthday   :date
#  url        :string
#  company_id :integer
#  email      :string
#  gender     :string
#
# Indexes
#
#  index_users_on_company_id  (company_id)
#
# Foreign Keys
#
#  fk_rails_7682a3bdfe  (company_id => companies.id)
#

class User < ActiveRecord::Base
  belongs_to :company
  has_many :events, dependent: :destroy
  has_many :statistics, dependent: :destroy
  has_many :devices
  validates :name, :provider, :uid, :company, presence: true

  scope :birthdays, -> { where("extract(month from birthday) = ? AND
                               extract(day from birthday) >= ?",
                               Date.today.strftime('%m'),
                               Date.today.strftime('%d')) }

  def add_event(action)
    events.create!(action: action, provider: self.provider, company: self.company)
  end

  def add_statistic(browser, mac)
    statistics.create!(company: self.company, provider: self.provider,
                       platform: browser.platform, browser: browser.name,
                       mac: mac)
  end

  def self.from_omniauth(auth, company)
    where(provider: auth.provider, uid: auth.uid.to_s, company: company).first || User.create_with_omniauth(auth, company)
  end

  def self.create_with_omniauth(auth, company)
    create! do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.company = company
      user.name = auth.info.name || ""
      case auth.provider
      when 'facebook'  then create_facebook(user, auth)
      when 'vkontakte' then create_vkontakte(user, auth)
      when 'twitter'   then create_twitter(user, auth)
      when 'instagram' then create_instagram(user, auth)
      when 'odnoklassniki' then create_odnoklassniki(user, auth)
      end
    end
  end

  def self.create_facebook(user, auth)
    raw_info = auth.extra.raw_info
    user.url = auth.info.urls[user.provider.capitalize] || ''
    user.email = auth.info.email || ''
    user.birthday = Date.strptime(raw_info.birthday, '%m/%d/%Y') if raw_info.birthday
    user.gender = raw_info.gender
  end

  def self.create_vkontakte(user, auth)
    raw_info = auth.extra.raw_info
    user.url = auth.info.urls[user.provider.capitalize] || ''
    user.email = auth.info.email || ''
    user.birthday = parse_vk_bdate(raw_info.bdate)
    user.gender = case raw_info.sex
      when 1 then :female
      when 2 then :male
      else ''
    end
  end

  def self.parse_vk_bdate(bdate)
    return unless bdate

    # Format "23.11.1981" or "21.9" (if year hidden)
    day, month, year = bdate.split('.').map(&:to_i)

    year ||= 1912 # Point for non year bdate

    Date.new(year, month, day)
  end

  def self.create_twitter(user, auth)
    user.url = auth.info.urls[user.provider.capitalize] || ''
  end

  def self.create_instagram(user, auth)
    user.url = 'https://instagram.com/' + auth.info.nickname
  end

  def self.create_odnoklassniki(user, auth)
    raw_info = auth.extra.raw_info
    user.url = auth.info.urls[user.provider.capitalize] || ''
    user.email = auth.info.email || ''
    user.birthday = Date.strptime(raw_info.birthday, '%Y-%m-%d') if raw_info.birthday
    user.gender = raw_info.gender
  end

  def macs
    statistics.collect(&:mac).compact.uniq
  end

  def self.to_csv
    attributes = %w(id name gender provider uid email birthday created_at updated_at)

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |user|
        csv << attributes.map{ |attr| user.send(attr) }
      end
    end
  end
end
