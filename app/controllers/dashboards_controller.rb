class DashboardsController < ApplicationController
  before_filter :authenticate_admin!

  def show
    @recent_events = Event.order('created_at DESC').first(10)
  end
end
