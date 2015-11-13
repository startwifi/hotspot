class Social::TwsController < ApplicationController
  before_filter :authenticate_admin!

  def edit
    @tw = current_admin.company.tw
  end

  def update
    @tw = current_admin.company.tw
    if @tw.update(tw_params)
      redirect_to edit_social_tw_path, notice: t('.success')
    else
      render :edit
    end
  end

  private

  def tw_params
    params.require(:tw)
      .permit(:group_name, :post_text, :post_link, :action, :link_redirect,
              :post_image, :post_image_cache, :remove_post_image)
  end
end
