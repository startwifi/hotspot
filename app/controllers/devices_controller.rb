class DevicesController < ApplicationController
  load_and_authorize_resource find_by: :mac

  def index
    @devices = @devices.select(:mac).distinct
  end

  def show
  end
end
