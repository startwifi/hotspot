class EventsController < ApplicationController
  def subscribe
    case params[:provider]
    when 'fb'
      current_user.add_event(:join, :facebook, current_user.company)
      redirect_to router_url
    when 'vk'
      current_user.add_event(:join, :vkontakte, current_user.company)
      redirect_to router_url
    when 'tw'
      client = twitter_client
      client.follow(current_user.company.tw.group_name)
      current_user.add_event(:join, :twitter, current_user.company)
      redirect_to router_url
    end
  end

  def post
    case params[:provider]
    when 'fb'
      image = current_user.company.fb.post_image? ? "#{root_url.chop + current_user.company.fb.post_image.url}" : nil
      graph = Koala::Facebook::API.new(session[:user_access_token])
      share = graph.put_wall_post(current_user.company.fb.post_text,
        { link: current_user.company.fb.post_link,
        description: current_user.company.fb.post_text,
        picture: image })
      if share['id']
        current_user.add_event(:post, :facebook, current_user.company)
        redirect_to router_url
      else
        render text: 'Error'
      end
    when 'vk'
      current_user.add_event(:post, :vkontakte, current_user.company)
      redirect_to router_url
    when 'tw'
      client = twitter_client
      if current_user.company.tw.post_image?
        client.update_with_media(current_user.company.tw.post_text, File.new("#{current_user.company.tw.post_image.path}"))
      else
        client.update(current_user.company.tw.post_text)
      end
      current_user.add_event(:post, :twitter, current_user.company)
      redirect_to router_url
    end
  end

  private

  def twitter_client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.secrets.twitter_key
      config.consumer_secret     = Rails.application.secrets.twitter_secret
      config.access_token        = session[:user_token]
      config.access_token_secret = session[:user_secret]
    end
  end
end
