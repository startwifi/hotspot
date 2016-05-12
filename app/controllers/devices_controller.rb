class DevicesController < ApplicationController
  load_and_authorize_resource only: :index

  def index
  end

  def show
    @device = Device.find_by_mac(params[:id])
    @phones = Device.where(mac: @device.mac).collect(&:phone)
    authorize! :show, @device
  end
end
