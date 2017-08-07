class StatisticService
  def initialize(user, request)
    @user = user
    @request = request
  end

  def call
    add_statistic
    assign_device
    add_event
  end

  private

  def add_statistic
    @user.statistics.create!(
      company: @user.company,
      provider: @user.provider,
      platform: browser.platform, browser: browser.name,
      #
      mac: @request.session[:mac]
    )
  end

  def assign_device
    @user.company.devices.find_or_create_by(
      mac: @request.session[:mac],
      user: @user
    )
  end

  def add_event
    @user.add_event(:login)
  end

  def browser
    @browser = Browser.new(ua: @request.env['HTTP_USER_AGENT'])
  end
end
