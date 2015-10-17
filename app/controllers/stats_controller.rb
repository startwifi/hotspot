class StatsController < ApplicationController
  before_filter :authenticate_admin!

  def show
    company = current_admin.company
    @social_networks = company.users.group(:provider).count
    @genders = company.users.group(:gender).count
    @activity = company.events.group_by_day(:created_at).count
  end
end
