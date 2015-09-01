class EventsController < ApplicationController
  def subscribe
    current_user.add_event(:subscribe)
    redirect_to router_url
  end

  def post
    current_user.add_event(:post)
    redirect_to router_url
  end
end
