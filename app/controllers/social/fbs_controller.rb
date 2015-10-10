class Social::FbsController < ApplicationController
  before_filter :authenticate_admin!

  def edit
    @fb = current_admin.company.fb
  end

  def update
    @fb = current_admin.company.fb
    if @fb.update(fb_params)
      redirect_to edit_social_fb_path, notice: "Facebook successfully updated."
    else
      render :edit
    end
  end

  private

  def fb_params
    params.require(:fb).permit(:group_name, :post_text, :post_link,
      :link_redirect, :action, :post_image, :post_image_cache, :remove_post_image)
  end
end
