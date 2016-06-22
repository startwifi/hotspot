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
    when 'sms' then widget_sms
    end
  end

  private

  def widget_sms
    case @company.sms.action
    when 'auth'
      redirect_to event_auth_path(:sms)
    when 'ident_auth'
      current_user.add_event(:sms_ident)
      session[:sms_auth_success] = true
      render 'visitors/index'
    when 'ident'
      if @company.sms.adv
        current_user.add_event(:sms_ident)
        render 'widgets/sms/adv'
      else
        redirect_to event_auth_path(:sms_ident)
      end
    end
  end

  def widget_fb
    case @company.fb.action
    when 'post'
      render 'widgets/fb/post'
    when 'join'
      is_member?('fb', @company.fb.group_id) ? redirect_to(event_member_path(:fb)) : render('widgets/fb/join')
    when 'auth'
      redirect_to event_auth_path(:fb)
    end
  end

  def widget_tw
    case @company.tw.action
    when 'join'
      render 'widgets/tw/join'
    when 'post'
      render 'widgets/tw/post'
    when 'auth'
      redirect_to event_auth_path(:tw)
    end
  end

  def widget_vk
    case @company.vk.action
    when 'post'
      @image = @company.vk.post_image? ? "#{root_url.chop + @company.vk.post_image.url}": nil
      render 'widgets/vk/post'
    when 'join'
      is_member?('vk', @company.vk.group_name) ? redirect_to(event_member_path(:vk)) : render('widgets/vk/join')
    when 'auth'
      redirect_to event_auth_path(:vk)
    end
  end

  def widget_in
    case @company.in.action
    when 'post'
      render 'widgets/in/post'
    when 'join'
      render 'widgets/in/join'
    when 'auth'
      redirect_to event_auth_path(:in)
    end
  end

  def widget_ok
    case @company.ok.action
    when 'post'
      render 'widgets/ok/post'
    when 'join'
      is_member?('ok', @company.ok.group_name) ? redirect_to(event_member_path(:ok)) : render('widgets/ok/join')
    when 'auth'
      redirect_to event_auth_path(:ok)
    end
  end

  def social_layout
    case current_user.provider
    when 'vkontakte'     then 'vk'
    when 'facebook'      then 'fb'
    when 'twitter'       then 'tw'
    when 'odnoklassniki' then 'ok'
    when 'sms'           then 'visitors'
    end
  end

  def is_member?(social, group)
    case social
    when 'vk'
      group = RestClient.post 'https://api.vk.com/method/groups.isMember', { group_id: group, user_id: current_user.uid }
      member = JSON.parse(group.body).first[1] == 1 ? true : false
    when 'fb'
      graph = Koala::Facebook::API.new(session[:user_token])
      graph.get_connections('me', "likes/#{group}").any?
    when 'ok'
      client = Odnoklassniki::Client.new(access_token: session[:user_token])
      client.get('group.getUserGroupsByIds', group_id: group, uids: current_user.uid).any?
    end
  end
end
