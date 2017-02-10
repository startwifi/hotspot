class Social::VksController < ApplicationController
  load_and_authorize_resource :company, through: :current_admin, singleton: true
  load_and_authorize_resource through: :company, singleton: true

  def edit
  end

  def update
    if @vk.update(vk_params)
      redirect_to edit_social_vk_path, notice: t('.success')
    else
      render :edit
    end
  end

  private

  def vk_params
    params.require(:vk).permit(
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
