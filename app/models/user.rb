class User < ActiveRecord::Base
  belongs_to :company

  has_many :events

  validates :name, :provider, :uid, :company, presence: true

  def add_event(action = '')
    events.create!(action: action)
  end

  def self.from_omniauth(auth, company)
    where(provider: auth.provider, uid: auth.uid.to_s, company: company).first || User.create_with_omniauth(auth, company)
  end

  def self.create_with_omniauth(auth, company)
    create! do |user|
      user.provider = auth.provider
      user.uid      = auth.uid
      user.company  = company
      hash = auth.extra.raw_info
      if auth.info
        user.name = auth.info.name || ""
        user.url = auth.info.urls[user.provider.capitalize] || ""
        user.email = auth.info.email || ""
        user.birthday = get_birthday(user.provider, hash)
        user.gender = get_gender(user.provider, hash)
      end
    end
  end

  def self.get_birthday(provider, hash)
    case provider
    when 'facebook'
      Date.strptime(hash.birthday, '%m/%d/%Y')
    when 'vkontakte'
      hash.bdate.to_date
    when 'odnoklassniki'
      Date.strptime(hash.birthday, '%Y-%m-%d')
    else
      nil
    end if hash.birthday || hash.bdate
  end

  def self.get_gender(provider, hash)
    case provider
    when 'facebook'
      hash.gender
    when 'vkontakte'
      if hash.sex == 1
        :female
      elsif hash.sex == 2
        :male
      else
        ""
      end
    when 'odnoklassniki'
      hash.gender
    end
  end

end
