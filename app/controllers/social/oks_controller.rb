class Social::OksController < ApplicationController
  before_filter :authenticate_admin!

  def edit
    @ok = current_admin.company.ok
  end

  def update
    @ok = current_admin.company.ok
    if @ok.update(ok_params)
      redirect_to edit_social_ok_path, notice: t('.success')
    else
      render :edit
    end
  end

  private

  def ok_params
    params.require(:ok)
      .permit(:group_name, :post_text, :post_link, :action, :link_redirect,
              :post_image, :post_image_cache, :remove_post_image)
  end
end
