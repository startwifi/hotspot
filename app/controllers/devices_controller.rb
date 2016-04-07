class DevicesController < ApplicationController
  def show
    @device = Device.find_by_mac(params[:id])
    authorize! :show, @device
  end
end
