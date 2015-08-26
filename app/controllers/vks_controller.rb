class VksController < ApplicationController
  before_filter :authenticate_admin!

  def show
    @vk = current_admin.company.vk
  end

  def new
    render_404 if current_admin.company.vk
    @vk = current_admin.company.build_vk
  end

  def create
    @vk = current_admin.company.build_vk(vk_params)
    @vk.group_id = get_group_id(@vk.group_name)
    if @vk.save
      redirect_to settings_vk_path, notice: "Vk successfully created."
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
      redirect_to settings_vk_path, notice: "Vk successfully updated."
    else
      render :edit
    end
  end

  private

  def vk_params
    params.require(:vk).permit(:group_name, :post_text, :post_link, :link_redirect, :action)
  end

  def get_group_id(group_name)
    begin
      group = RestClient.post 'https://api.vk.com/method/groups.getById', { group_id: group_name }
      group_id = JSON.parse(group.body).first[1][0]['gid']
    rescue
      errors.add :group_name, "can't be blank."
    end
  end
end
