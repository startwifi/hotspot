class Social::VksController < ApplicationController
  before_filter :authenticate_admin!

  def edit
    @vk = current_admin.company.vk
  end

  def update
    @vk = current_admin.company.vk
    if @vk.update(vk_params)
      redirect_to edit_social_vk_path, notice: t('.success')
    else
      render :edit
    end
  end

  private

  def vk_params
    params.require(:vk)
      .permit(:group_name, :post_text, :post_link, :action, :link_redirect,
              :post_image, :post_image_cache, :remove_post_image)
  end
end
