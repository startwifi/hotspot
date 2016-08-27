class UsersController < ApplicationController
  before_action :authenticate_admin!
  load_and_authorize_resource

  def index
    @q = @users.ransack(params[:q])
    @users = @q.result(distinct: true)
    respond_to do |format|
      format.html
      format.csv { send_data @users.to_csv, filename: "users-#{Date.today}.csv" }
    end
  end

  def show
  end

end
