class WidgetsController < ApplicationController
  layout :social_layout

  def show
    @company = current_user.company
    case current_user.provider
    when 'facebook'  then widget_fb
    when 'twitter'   then widget_tw
    when 'vkontakte' then widget_vk
    when 'instagram' then widget_in
    when 'odnoklassniki' then widget_ok
    else
      render_404
    end
  end

  private

  def widget_fb
    case @company.fb.action
    when 'post'
      render 'widgets/fb/post'
    when 'join'
      is_member?('fb', @company.fb.group_id) ? redirect_to(router_url) : render('widgets/fb/join')
    when 'card'
      render 'widgets/card'
    else
      redirect_to router_url
    end
  end

  def widget_tw
    case @company.tw.action
    when 'join'
      render 'widgets/tw/join'
    when 'post'
      render 'widgets/tw/post'
    when 'card'
      render 'widgets/card'
    else
      redirect_to router_url
    end
  end

  def widget_vk
    case @company.vk.action
    when 'post'
      @image = @company.vk.post_image? ? "#{root_url.chop + @company.vk.post_image.url}": nil
      render 'widgets/vk/post'
    when 'join'
      is_member?('vk', @company.vk.group_name) ? redirect_to(router_url) : render('widgets/vk/join')
    when 'card'
      render 'widgets/card'
    else
      redirect_to router_url
    end
  end

  def widget_in
    case @company.in.action
    when 'post'
      render 'widgets/in/post'
    when 'join'
      render 'widgets/in/join'
    when 'card'
      render 'widgets/card'
    else
      redirect_to router_url
    end
  end

  def widget_ok
    case @company.ok.action
    when 'post'
      render 'widgets/ok/post'
    when 'join'
      render 'widgets/ok/join'
    when 'card'
      render 'widgets/card'
    else
      redirect_to router_url
    end
  end

  def social_layout
    case current_user.provider
    when 'vkontakte'     then 'vk'
    when 'facebook'      then 'fb'
    when 'twitter'       then 'tw'
    when 'odnoklassniki' then 'ok'
    end
  end

  def is_member?(social, group)
    if social == 'vk'
      group = RestClient.post 'https://api.vk.com/method/groups.isMember', { group_id: group, user_id: current_user.uid }
      member = JSON.parse(group.body).first[1] == 1 ? true : false
    elsif social == 'fb'
      graph = Koala::Facebook::API.new(session[:user_access_token])
      member = unless graph.get_connections('me', "likes/#{group}").empty?
        true
      else
        false
      end
    end
  end
end
