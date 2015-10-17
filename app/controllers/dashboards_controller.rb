class DashboardsController < ApplicationController
  before_filter :authenticate_admin!

  def show
    unless current_admin.admin?
      @company = current_admin.company
      @recent_events = @company.events.today.order('created_at DESC')
      @days_range = get_range.to_a.reverse
      @events = get_events_by_month.where('action != ?', 'login')
    else
      redirect_to companies_path
    end
  end

  def get_range
    if params[:date] && params[:date][:month].to_i < Time.current.month
      month = DateTime.new(Time.now.year, params[:date][:month].to_i).to_date
      (month..month.end_of_month)
    else
      (Time.now.beginning_of_month.to_date..Time.now.to_date)
    end
  end

  def get_events_by_month
    params[:date] ? @company.events.by_month(params[:date][:month].to_i) :
      @company.events.month
  end
end
