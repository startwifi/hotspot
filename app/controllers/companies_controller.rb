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

  private

  def company_params
    params.require(:company).permit(:name, :owner_name, :phone, :address)
  end

  def admin_params
    params.require(:admin).permit(:email, :password, :password_confirmation)
  end
end
