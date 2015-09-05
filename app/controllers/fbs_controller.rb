class FbsController < ApplicationController
  before_filter :authenticate_admin!

  def show
    @fb = current_admin.company.fb
  end

  def new
    render_404 if current_admin.company.fb
    @fb = current_admin.company.build_fb
  end

  def create
    @fb = current_admin.company.build_fb(fb_params)
    @fb.group_id = get_group_id(@fb.group_name)
    if @fb.save
      redirect_to settings_fb_path, notice: "Facebook successfully created."
    else
      render :new
    end
  end

  def edit
    @fb = current_admin.company.fb
  end

  def update
    @fb = current_admin.company.fb
    @fb.group_id = get_group_id(params[:fb][:group_name])
    if @fb.update(fb_params)
      redirect_to settings_fb_path, notice: "Facebook successfully updated."
    else
      render :edit
    end
  end

  private

  def fb_params
    params.require(:fb).permit(:group_name, :post_text, :post_link, :link_redirect, :action)
  end

  def get_group_id(group_name)
    begin
      oauth = Koala::Facebook::OAuth.new(ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'])
      graph = Koala::Facebook::API.new(oauth.get_app_access_token)
      graph.get_object(group_name)['id']
    rescue
      nil
    end
  end
end
