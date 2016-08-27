class AdminsController < ApplicationController
  load_and_authorize_resource :company
  load_and_authorize_resource through: :company

  def new
  end

  def create
    if @admin.save
      redirect_to @company, notice: t('.success')
    else
      flash.now[:alert] = t('.errors')
      render :new
    end
  end

  def admin_params
    params.require(:admin).permit(:email, :password, :password_confirmation)
  end
end
