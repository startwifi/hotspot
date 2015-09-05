class WidgetsController < ApplicationController
  layout :social_layout

  def show
    begin
      @company = current_user.company
      if current_user.provider == 'vkontakte' && @company.vk.action == 'post'
        render 'widgets/vk/post'
      elsif current_user.provider == 'vkontakte' && @company.vk.action == 'join'
        if is_member?('vk', @company.vk.group_name)
          redirect_to router_url
        else
          render 'widgets/vk/join'
        end
      elsif current_user.provider == 'facebook' && @company.fb.action == 'post'
        render 'widgets/fb/post'
      elsif current_user.provider == 'facebook' && @company.fb.action == 'join'
        if is_member?('fb', @company.fb.group_id)
          redirect_to router_url
        else
          render 'widgets/fb/join'
        end
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
      'twitter'
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
