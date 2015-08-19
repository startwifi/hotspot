class UsersController < ApplicationController
  before_filter :authenticate_admin!

  def index
    @users = current_admin.company.users
  end

  def show
    @user = current_admin.company.users.find(params[:id])
  end

end
