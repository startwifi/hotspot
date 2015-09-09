class DashboardsController < ApplicationController
  before_filter :authenticate_admin!

  def show
    unless current_admin.admin?
      @recent_events = current_admin.company.events.order('created_at DESC').first(10)
    else
      redirect_to companies_path
    end
  end
end
