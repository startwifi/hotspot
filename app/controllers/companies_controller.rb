class CompaniesController < ApplicationController
  before_filter :authenticate_admin!
  load_and_authorize_resource

  def index
  end

  def show
    @admins = @company.admins
    @recent_events = @company.events.order('created_at DESC').first(10)
  end

  def new
  end

  def new_admin
    @admin = Admin.new
  end

  def create
    @company.cover = Rails.root.join('app/assets/images/startwifi.png').open
    if @company.save
      @company.create_dummy_social(:fb, :vk, :tw, :in, :ok)
      redirect_to companies_path, notice: 'Company successfully created.'
    else
      render :new
    end
  end

  def create_admin
    @admin = Admin.new(admin_params)
    @admin.company = @company
    if @admin.save
      redirect_to @company, notice: 'Admin successfully added.'
    else
      flash.now[:alert] = 'Form contains some errors'
      render :new_admin
    end
  end

  private

  def company_params
    params.require(:company).permit(:name, :owner_name, :phone, :address)
  end

  def admin_params
    params.require(:admin).permit(:email, :password, :password_confirmation)
  end
end
