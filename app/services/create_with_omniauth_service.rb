class CreateWithOmniauthService
  def initialize(company, auth)
    @company = company
    @auth = auth
    @raw_info = @auth.extra.raw_info if @auth.extra
  end

  def call
    @user = User.find_by(provider: @auth.provider, uid: @auth.uid.to_s, company: @company)
    @user ? update_user : create_user
  end

  private

  def create_user
    User.create do |user|
      user.provider = @auth.provider
      user.uid = @auth.uid
      user.company = @company
      user.name = @auth.info.name || ''
      build_provider(user)
    end
  end

  def update_user
    @user.tap do |user|
      user.name = @auth.info.name || ''
      build_provider(user)
    end
    @user.save
    @user
  end

  def build_provider(user)
    case @auth.provider
    when 'facebook'
      build_facebook(user)
    when 'vkontakte'
      build_vkontakte(user)
    when 'twitter'
      build_twitter(user)
    when 'instagram'
      build_instagram(user)
    when 'odnoklassniki'
      build_odnoklassniki(user)
    end
  end

  def build_facebook(user)
    user.url = @auth.info.urls[user.provider.capitalize] || ''
    user.email = @auth.info.email || ''
    user.birthday = Date.strptime(@raw_info.birthday, '%m/%d/%Y') if @raw_info.birthday
    user.gender = @raw_info.gender
  end

  def build_vkontakte(user)
    user.url = @auth.info.urls[user.provider.capitalize] || ''
    user.email = @auth.info.email || ''
    user.birthday = parse_vk_bdate
    user.gender = case @raw_info.sex
                    when 1 then :female
                    when 2 then :male
                    else ''
                  end
  end

  def build_twitter(user)
    user.url = @auth.info.urls[user.provider.capitalize] || ''
  end

  def build_instagram(user)
    user.url = "https://instagram.com/#{@auth.info.nickname}"
  end

  def build_odnoklassniki(user)
    user.url = @auth.info.urls[user.provider.capitalize] || ''
    user.email = @auth.info.email || ''
    user.birthday = Date.strptime(@raw_info.birthday, '%Y-%m-%d') if @raw_info.birthday
    user.gender = @raw_info.gender
  end

  def parse_vk_bdate
    return if @raw_info.bdate.blank?

    # Format "23.11.1981" or "21.9" (if year hidden)
    day, month, year = @raw_info.bdate.split('.').map(&:to_i)
    year ||= 1912 # Point for non year bdate

    Date.new(year, month, day)
  end
end
