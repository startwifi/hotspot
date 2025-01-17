class EventsController < ApplicationController
  def subscribe
    case params[:provider]
    when 'fb'
      current_user.add_event(:join)
      redirect_to router_url
    when 'vk'
      current_user.add_event(:join)
      redirect_to router_url
    when 'tw'
      client = twitter_client
      client.follow(current_user.company.tw.group_name)
      current_user.add_event(:join)
      redirect_to router_url
    when 'ok'
      current_user.add_event(:join)
      redirect_to router_url
    end
  end

  def post
    case params[:provider]
    when 'fb'
      post_facebook
    when 'vk'
      if VkPhotoUploadService.new(current_user.company, session[:user_token]).call
        current_user.add_event(:photo)
        redirect_to router_url
      else
        redirect_to auth_url
      end
    when 'tw'
      post_twitter
    end
  end

  # TODO: URGENT! Need to rewrite (access without action)
  def auth
    case params[:provider]
    when 'sms_ident_auth'
      return current_user.add_event(:auth) if session[:sms_auth_success].present?
      current_user.add_event(:sms_ident)
    when 'sms_ident'
      current_user.add_event(:sms_ident)
    when 'sms_ident_adv'
      current_user.add_event(:sms_ident_adv)
    when 'guest_skip'
      current_user.add_event(:guest_skip)
    when 'guest_adv'
      current_user.add_event(:guest_adv)
    when 'guest_password'
      current_user.add_event(:guest_password)
    else
      current_user.add_event(:auth)
    end
    redirect_to router_url
  end

  def post_facebook
    image = current_user.company.fb.post_image? ? (root_url.chop + current_user.company.fb.post_image.url).to_s : nil
    graph = Koala::Facebook::API.new(session[:user_token])
    share = graph.put_picture(image, caption: current_user.company.fb.post_text)
    if share['id']
      current_user.add_event(:post)
      redirect_to router_url
    else
      render text: 'Error'
    end
  rescue Koala::Facebook::ClientError => e
    redirect_to failure_path(message: e.fb_error_message)
  end

  def post_twitter
    client = twitter_client
    if current_user.company.tw.post_image?
      client.update_with_media(current_user.company.tw.post_text, File.new(current_user.company.tw.post_image.path))
    else
      client.update(current_user.company.tw.post_text)
    end
    current_user.add_event(:post)
    redirect_to router_url
  end

  def is_member
    current_user.add_event(:member)
    redirect_to router_url
  end

  def by_date
    company_events = current_admin.company.events
    @events = company_events.by_date(params[:date]).order('id DESC')
    render partial: 'by_date'
  end

  private

  def twitter_client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = Figaro.env.twitter_key
      config.consumer_secret     = Figaro.env.twitter_secret
      config.access_token        = session[:user_token]
      config.access_token_secret = session[:user_secret]
    end
  end
end
