class EventsController < ApplicationController
  def subscribe
    case params[:provider]
    when 'fb'
      current_user.add_event(:like)
      redirect_to router_url
    when 'vk'
      current_user.add_event(:subscribe)
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
        current_user.add_event(:share)
        redirect_to router_url
      else
        render text: 'Error'
      end
    when 'vk'
      current_user.add_event(:post)
      redirect_to router_url
    end
  end
end
