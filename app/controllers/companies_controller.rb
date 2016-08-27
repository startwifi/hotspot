class CompaniesController < ApplicationController
  before_action :authenticate_admin!
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

  def edit
  end

  def create
    @company.cover = Rails.root.join('app/assets/images/startwifi.png').open
    if @company.save
      DummySocialService.new(@company, :fb, :vk, :tw, :in, :ok).call
      redirect_to companies_path, notice: t('.success')
    else
      render :new
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
end
