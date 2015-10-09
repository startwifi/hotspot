class InsController < ApplicationController
  before_filter :authenticate_admin!

  def new
    render_404 if current_admin.company.in
    @in = current_admin.company.build_in
  end

  def create
    @in = current_admin.company.build_in(in_params)
    if @in.save
      redirect_to edit_settings_in_path, notice: "Instagram successfully created."
    else
      render :new
    end
  end

  def edit
    @in = current_admin.company.in
  end

  def update
    @in = current_admin.company.in
    if @in.update(in_params)
      redirect_to edit_settings_in_path, notice: "Facebook successfully updated."
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
