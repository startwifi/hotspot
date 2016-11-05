class PagesController < ApplicationController
  load_and_authorize_resource :company, through: :current_admin, singleton: true

  def tos
  end

  def tos_edit
  end

  def tos_update
    @company.tos_text = company_params[:tos_text]
    if @company.save
      redirect_to tos_pages_path, notice: t('pages.success')
    else
      render :tos_edit
    end
  end

  private

  def company_params
    params.require(:company).permit(:tos_text)
  end
end
