class VksController < ApplicationController
  before_filter :authenticate_admin!

  def new
    render_404 if current_admin.company.vk
    @vk = current_admin.company.build_vk
  end

  def create
    @vk = current_admin.company.build_vk(vk_params)
    if @vk.save
      redirect_to edit_settings_vk_path, notice: "Vk successfully created."
    else
      render :new
    end
  end

  def edit
    @vk = current_admin.company.vk
  end

  def update
    @vk = current_admin.company.vk
    if @vk.update(vk_params)
      redirect_to edit_settings_vk_path, notice: "Vk successfully updated."
    else
      render :edit
    end
  end

  private

  def vk_params
    params.require(:vk).permit(:group_name, :post_text, :post_link,
      :link_redirect, :action, :post_image, :post_image_cache, :remove_post_image)
  end
end
