class Social::SmsController < ApplicationController
  load_and_authorize_resource :company, through: :current_admin, singleton: true
  load_and_authorize_resource :sms, through: :company, singleton: true

  def edit
  end

  def update
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
