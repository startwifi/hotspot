class AgreementsController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def show
    agreement = params[:agreement]
    return render_404 unless agreement == 'tos' || agreement == 'privacy_policy'
    @agreement = Agreement.find_by(type: agreement.camelize)
  end

  def new
  end

  def edit
  end

  def create
    if @agreement.save
      redirect_to agreements_path, notice: t('.success')
    else
      render :new
    end
  end

  def update
    update_params = send("#{@agreement.type.underscore}_params")
    if @agreement.update(update_params)
      redirect_to agreements_path, notice: t('.success')
    else
      render :edit
    end
  end

  private

  def agreement_params
    params.require(:agreement).permit(:type, :agreement_text, :language)
  end

  def tos_params
    params.require(:tos).permit(:type, :agreement_text, :language)
  end

  def privacy_policy_params
    params.require(:privacy_policy).permit(:type, :agreement_text, :language)
  end
end
