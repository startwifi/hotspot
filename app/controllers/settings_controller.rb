class SettingsController < ApplicationController
  def show
    @company = current_admin.company
  end
end
