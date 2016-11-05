class Social::GuestsController < ApplicationController
  load_and_authorize_resource :company, through: :current_admin, singleton: true
  load_and_authorize_resource through: :company, singleton: true

  def edit
  end

  def update
    if @guest.update(guest_params)
      redirect_to edit_social_guest_path, notice: t('.success')
    else
      render :edit
    end
  end

  private

  def guest_params
    params.require(:guest).permit(
      :adv,
      :action,
      :link_redirect,
      :wall_head,
      :wall_text,
      :wall_image,
      :post_wall_cache,
      :remove_wall_image,
      :password
    )
  end
end
