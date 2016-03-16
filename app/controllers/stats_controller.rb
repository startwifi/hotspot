class StatsController < ApplicationController
  before_action :authenticate_admin!
  before_action :load_company

  def show
  end

  def social_networks
    render json: @company.users.group(:provider).count
  end

  def gender
    render json: @company.users.group(:gender).count
  end

  def activity
    render json: @company.events.group_by_day(:created_at).count
  end

  def events
    render json: @company.events.group(:action).count.except('login')
  end

  private

  def load_company
    @company = current_admin.company
  end
end
