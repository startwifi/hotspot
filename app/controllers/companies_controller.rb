class CompaniesController < ApplicationController
  before_filter :authenticate_admin!

  def index
    @companies = Company.all
  end

  def show
    @company = Company.find(params[:id])
    @admins = @company.admins
    @recent_events = @company.events.order('created_at DESC').first(10)
  end

  def new
    @company = Company.new
  end

  def new_admin
    @company = Company.find_by(id: params[:id])
    @admin = Admin.new
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to companies_path, notice: 'Company successfully created.'
    else
      render :new
    end
  end

  def create_admin
    @company = Company.find_by(id: params[:id])
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
