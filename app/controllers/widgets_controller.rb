class WidgetsController < ApplicationController
  layout :social_layout

  def show
    begin
      @company = current_user.company
      if current_user.provider == 'vkontakte' && @company.vk.action == 'post'
        @image = @company.vk.post_image? ? "#{root_url.chop + @company.vk.post_image.url}": nil
        render 'widgets/vk/post'
      elsif current_user.provider == 'vkontakte' && @company.vk.action == 'join'
        is_member?('vk', @company.vk.group_name) ? redirect_to(router_url) : render('widgets/vk/join')
      elsif current_user.provider == 'facebook' && @company.fb.action == 'post'
        render 'widgets/fb/post'
      elsif current_user.provider == 'facebook' && @company.fb.action == 'join'
        is_member?('fb', @company.fb.group_id) ? redirect_to(router_url) : render('widgets/fb/join')
      elsif current_user.provider == 'twitter' && @company.tw.action == 'join'
        render 'widgets/tw/join'
      elsif current_user.provider == 'odnoklassniki'
        redirect_to router_url
      end
    # rescue
    #   render_404
    end
  end

  private

  def social_layout
    case current_user.provider
    when 'vkontakte'
      'vk'
    when 'facebook'
      'fb'
    when 'twitter'
      'tw'
    when 'odnoklassniki'
      'ok'
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
