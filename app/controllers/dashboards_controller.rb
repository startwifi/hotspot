class DashboardsController < ApplicationController
  before_filter :authenticate_admin!

  def show
    unless current_admin.admin?
      @company = current_admin.company
      @recent_events = @company.events.today.order('created_at DESC')
      @days_range = (Time.now.beginning_of_month.to_date..Time.now.to_date).to_a.reverse
      @events = @company.events.month
    else
      redirect_to companies_path
    end
  end
end
