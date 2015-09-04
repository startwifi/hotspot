class EventsController < ApplicationController
  def subscribe
    current_user.add_event(:subscribe)
    redirect_to router_url
  end

  def post
    if params[:provider] == 'vk'
      current_user.add_event(:post)
      redirect_to router_url
    elsif params[:provider] == 'fb'
      graph = Koala::Facebook::API.new(session[:user_access_token])
      share = graph.put_wall_post(current_user.company.fb.post_text,
        { link: current_user.company.fb.post_link,
        description: current_user.company.fb.post_text })
      if share['id']
        redirect_to router_url
      else
        render text: 'Error'
      end
    end
  end
end
