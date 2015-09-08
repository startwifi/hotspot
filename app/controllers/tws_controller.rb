class TwsController < ApplicationController
  before_filter :authenticate_admin!

  def show
    @tw = current_admin.company.tw
  end

  def new
    render_404 if current_admin.company.tw
    @tw = current_admin.company.build_tw
  end

  def create
    @tw = current_admin.company.build_tw(tw_params)
    if @tw.save
      redirect_to settings_tw_path, notice: "Twitter successfully created."
    else
      render :new
    end
  end

  def edit
    @tw = current_admin.company.tw
  end

  def update
    @tw = current_admin.company.tw
    if @tw.update(tw_params)
      redirect_to settings_tw_path, notice: "Twitter successfully updated."
    else
      render :edit
    end
  end

  private

  def tw_params
    params.require(:tw).permit(:group_name, :post_text, :post_link,
      :link_redirect, :action, :post_image, :post_image_cache, :remove_post_image)
  end
end
