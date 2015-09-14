class FbsController < ApplicationController
  before_filter :authenticate_admin!

  def new
    render_404 if current_admin.company.fb
    @fb = current_admin.company.build_fb
  end

  def create
    @fb = current_admin.company.build_fb(fb_params)
    if @fb.save
      redirect_to edit_settings_fb_path, notice: "Facebook successfully created."
    else
      render :new
    end
  end

  def edit
    @fb = current_admin.company.fb
  end

  def update
    @fb = current_admin.company.fb
    if @fb.update(fb_params)
      redirect_to edit_settings_fb_path, notice: "Facebook successfully updated."
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
