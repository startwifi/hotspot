class Social::FbsController < ApplicationController
  load_and_authorize_resource :company, through: :current_admin, singleton: true
  load_and_authorize_resource through: :company, singleton: true

  def edit
  end

  def update
    if @fb.update(fb_params)
      redirect_to edit_social_fb_path, notice: t('.success')
    else
      render :edit
    end
  end

  private

  def fb_params
    params.require(:fb).permit(
      :group_name,
      :post_text,
      :post_link,
      :action,
      :link_redirect,
      :post_image,
      :post_image_cache,
      :remove_post_image,
      :api_key,
      :api_secret
    )
  end
end
