class RoutersController < ApplicationController
  before_action :load_company
  before_action :find_router, only: [:show, :edit, :update, :destroy]

  def index
    @routers = @company.routers
  end

  def show
  end

  def new
    @router = @company.routers.build
  end

  def create
    @router = @company.routers.build(router_params)

    @router.ping

    if @router.online? && @router.save
      redirect_to routers_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @router.ping

    if @router.online? && @router.update(router_params)
      redirect_to routers_path
    else
      render :edit
    end
  end

  def destroy
    @router.destroy

    redirect_to routers_path
  end

  private

  def router_params
    params.require(:router).permit(:ip_address, :name, :login, :password)
  end

  def load_company
    @company = current_admin.company
  end

  def find_router
    @router = @company.routers.find(params[:id])
  end
end
