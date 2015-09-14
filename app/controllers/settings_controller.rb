class SettingsController < ApplicationController
  before_filter :authenticate_admin!

  def edit
    @company = current_admin.company
  end

  def update
    @company = current_admin.company
    @company.fb.update(fb_params)
    @company.vk.update(vk_params)
    @company.tw.update(tw_params)
    redirect_to edit_settings_path, notice: 'Settings successfully updated.'
  end

  private

  def fb_params
    params.require(:fb).permit(:action)
  end

  def vk_params
    params.require(:vk).permit(:action)
  end

  def tw_params
    params.require(:tw).permit(:action)
  end
end
