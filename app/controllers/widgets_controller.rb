class WidgetsController < ApplicationController
  layout :social_layout

  def show
    @company = current_user.company
    if current_user.provider == 'vkontakte' && @company.vk.action == 'post'
      render 'widgets/vk/post'
    elsif current_user.provider == 'vkontakte' && @company.vk.action == 'join'
      if current_user.is_member?('vk', @company.vk.group_name)
        redirect_to @company.vk.link_redirect
      else
        render 'widgets/vk/join'
      end
    end
  end

  private

  def social_layout
    case current_user.provider
    when 'vkontakte'
      'vk'
    when 'fb'
      'fb'
    when 'twitter'
      'twitter'
    end
  end
end
