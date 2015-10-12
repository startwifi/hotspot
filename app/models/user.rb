class User < ActiveRecord::Base
  belongs_to :company
  has_many :events, dependent: :destroy
  has_many :statistics, dependent: :destroy
  validates :name, :provider, :uid, :company, presence: true

  def add_event(action, provider, company)
    events.create!(action: action, provider: provider, company: company)
  end

  def add_statistic(browser, mac)
    statistics.create!(company: self.company, provider: self.provider,
      platform: browser.platform, browser: browser.name, mac: mac)
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
    user.birthday = raw_info.bdate.to_date if raw_info.bdate
    user.gender = case raw_info.sex
      when 1 then :female
      when 2 then :male
      else ''
    end
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
end
