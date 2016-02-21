class PagesController < ApplicationController
  before_action :load_company

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

  def load_company
    @company = current_admin.company
  end
end
