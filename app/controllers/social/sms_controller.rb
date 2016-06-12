class Social::SmsController < ApplicationController
  before_filter :authenticate_admin!

  def edit
    @sms = current_admin.company.sms
  end

  def update
    @sms = current_admin.company.sms
    if @sms.update(sms_params)
      redirect_to edit_social_sms_path, notice: t('.success')
    else
      render :edit
    end
  end

  private

  def sms_params
    params.require(:sms).permit(
      :adv,
      :action,
      :link_redirect,
      :wall_head,
      :wall_text,
      :wall_image,
      :post_wall_cache,
      :remove_wall_image
    )
  end
end
