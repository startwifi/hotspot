class Social::InsController < ApplicationController
  before_filter :authenticate_admin!

  def edit
    @in = current_admin.company.in
  end

  def update
    @in = current_admin.company.in
    if @in.update(in_params)
      redirect_to edit_social_in_path, notice: "Facebook successfully updated."
    else
      render :edit
    end
  end

  private

  def in_params
    params.require(:in).permit(:group_name, :post_text, :post_link,
      :link_redirect, :action, :post_image, :post_image_cache, :remove_post_image)
  end
end
