class Social::TwsController < ApplicationController
  load_and_authorize_resource :company, through: :current_admin, singleton: true
  load_and_authorize_resource through: :company, singleton: true

  def edit
  end

  def update
    if @tw.update(tw_params)
      redirect_to edit_social_tw_path, notice: t('.success')
    else
      render :edit
    end
  end

  private

  def tw_params
    params.require(:tw).permit(
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
