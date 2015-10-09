class OksController < ApplicationController
  before_filter :authenticate_admin!

  def new
    render_404 if current_admin.company.ok
    @ok = current_admin.company.build_ok
  end

  def create
    @ok = current_admin.company.build_ok(ok_params)
    if @ok.save
      redirect_to edit_settings_ok_path, notice: "Ok successfully created."
    else
      render :new
    end
  end

  def edit
    @ok = current_admin.company.ok
  end

  def update
    @ok = current_admin.company.ok
    if @ok.update(ok_params)
      redirect_to edit_settings_ok_path, notice: "Ok successfully updated."
    else
      render :edit
    end
  end

  private

  def ok_params
    params.require(:ok).permit(:group_name, :post_text, :post_link,
      :link_redirect, :action, :post_image, :post_image_cache, :remove_post_image)
  end
end
