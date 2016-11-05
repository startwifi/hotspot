class DevicesController < ApplicationController
  load_and_authorize_resource :company, through: :current_admin, singleton: true
  load_and_authorize_resource through: :company, find_by: :mac

  def index
    @devices = @devices.select(:mac).distinct
  end

  def show
  end
end
