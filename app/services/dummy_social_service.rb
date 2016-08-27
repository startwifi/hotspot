class DummySocialService
  def initialize(company, *socials)
    @company = company
    @socials = socials
  end

  def call
    create_dummy_socials
  end

  private

  def create_dummy_socials
    @socials.each do |social|
      @company.send("create_#{social}",
        group_name: get_group_name(social),
        action: 'disabled',
        link_redirect: Figaro.env.link_redirect,
        post_text: @company.name,
        post_link: get_group_link(social),
        post_image: Rails.root.join('app/assets/images/startwifi.png').open)
    end
  end

  def get_group_name(social)
    case social
    when :fb then Figaro.env.fb_group_name
    when :vk then Figaro.env.vk_group_name
    when :tw then Figaro.env.tw_group_name
    when :in then Figaro.env.in_group_name
    when :ok then Figaro.env.ok_group_name
    end
  end

  def get_group_link(social)
    case social
    when :fb then "https://facebook.com/#{Figaro.env.fb_group_name}"
    when :vk then "https://vk.com/#{Figaro.env.vk_group_name}"
    when :tw then "https://twitter.com/#{Figaro.env.tw_group_name}"
    when :in then "https://instagram.com/#{Figaro.env.in_group_name}"
    when :ok then "https://ok.ru/group/#{Figaro.env.ok_group_name}"
    end
  end
end
