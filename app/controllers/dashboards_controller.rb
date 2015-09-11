class DashboardsController < ApplicationController
  before_filter :authenticate_admin!

  def show
    unless current_admin.admin?
      @recent_events = current_admin.company.events.order('created_at DESC').first(10)
      @company = current_admin.company
      @days_range = (Time.now.beginning_of_month.to_date..Time.now.to_date).to_a.reverse
      @events = current_admin.company.events.month
    else
      redirect_to companies_path
    end
  end
end
