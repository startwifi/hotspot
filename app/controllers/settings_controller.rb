class SettingsController < ApplicationController
  load_and_authorize_resource :company, through: :current_admin, singleton: true

  def edit
  end

  def update
    if @company.update(company_params)
      @company.fb.update(fb_params)
      @company.vk.update(vk_params)
      @company.tw.update(tw_params)
      @company.in.update(in_params)
      @company.ok.update(ok_params)
      @company.sms.update(sms_params)
      @company.guest.update(guest_params)
      redirect_to edit_settings_path, notice: t('.success')
    else
      render :edit
    end
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

  def in_params
    params.require(:in).permit(:action)
  end

  def ok_params
    params.require(:ok).permit(:action)
  end

  def sms_params
    params.require(:sms).permit(:action)
  end

  def guest_params
    params.require(:guest).permit(:action)
  end

  def company_params
    params.require(:company).permit(
      :link_redirect,
      :action,
      :cover,
      :cover_cache,
      :remove_cover,
      :card,
      :card_cache,
      :remove_card,
      :tos,
      :tos_text,
      :layout
    )
  end
end
