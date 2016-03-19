# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  name       :string
#  token      :string
#  phone      :string
#  address    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  owner_name :string
#  cover      :string
#  card       :string
#

class CompaniesController < ApplicationController
  before_filter :authenticate_admin!
  load_and_authorize_resource

  layout 'visitors', only: :suspended

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

  def edit
  end

  def create
    @company.cover = Rails.root.join('app/assets/images/startwifi.png').open
    if @company.save
      @company.create_dummy_social(:fb, :vk, :tw, :in, :ok)
      redirect_to companies_path, notice: t('.success')
    else
      render :new
    end
  end

  def create_admin
    @admin = Admin.new(admin_params)
    @admin.company = @company
    if @admin.save
      redirect_to @company, notice: t('.success')
    else
      flash.now[:alert] = t('.errors')
      render :new_admin
    end
  end

  def update
    if @company.update(company_params)
      redirect_to @company, notice: t('.success')
    else
      flash.now[:alert] = t('.errors')
      render :edit
    end
  end

  def destroy
    if @company.destroy
      redirect_to companies_path, notice: t('.success')
    else
      redirect_to @company, alert: t('.errors')
    end
  end

  def hold
    toggle_status = CompanySuspendService.new(@company)
    if toggle_status.call
      redirect_to companies_path, notice: t('.success')
    else
      redirect_to companies_path, alert: t('.errors')
    end
  end

  def suspended
    flash.now[:error] = "Обслуживание приостановлено"
  end

  private

  def company_params
    params.require(:company).permit(:name, :owner_name, :phone, :address)
  end

  def admin_params
    params.require(:admin).permit(:email, :password, :password_confirmation)
  end
end
