class SettingsController < ApplicationController
  before_filter :authenticate_admin!

  def edit
    @company = current_admin.company
  end

  def update
    @company = current_admin.company
    if @company.update(company_params)
      @company.fb.update(fb_params)
      @company.vk.update(vk_params)
      @company.tw.update(tw_params)
      @company.in.update(in_params)
      @company.ok.update(ok_params)
      @company.sms.update(sms_params)
      redirect_to edit_settings_path, notice: t('.success')
    else
      render :edit
    end
  end

  def advanced
    @company = current_admin.company
  end

  def advanced_update
    @company = current_admin.company
    if @company.update(company_params)
      redirect_to advanced_settings_path, notice: t('.success')
    else
      render :advanced
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
      :sms_auth,
      :sms_auth_link_redirect
    )
  end
end
