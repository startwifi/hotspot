class Social::OksController < ApplicationController
  load_and_authorize_resource :company, through: :current_admin, singleton: true
  load_and_authorize_resource through: :company, singleton: true

  def edit
  end

  def update
    if @ok.update(ok_params)
      redirect_to edit_social_ok_path, notice: t('.success')
    else
      render :edit
    end
  end

  private

  def ok_params
    params.require(:ok).permit(
      :group_name,
      :post_text,
      :post_link,
      :action,
      :link_redirect,
      :post_image,
      :post_image_cache,
      :remove_post_image,
      :api_key,
      :api_secret,
      :api_public
    )
  end
end
