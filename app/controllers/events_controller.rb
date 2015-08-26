class EventsController < ApplicationController
  def subscribe
    current_user.add_event('subscribe')
    redirect_to current_user.company.vk.link_redirect
  end
end
