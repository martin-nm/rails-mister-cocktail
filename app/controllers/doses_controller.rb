class DosesController < ApplicationController

  def new
    @dose = dose.new
  end

  def create
    @dose = dose.new(dose_params)
    @dose.save!
    redirect_to dose_path(@dose)
  end

  def destroy
    @dose = dose.find(params[:id])
    @dose.destroy
    redirect_to cocktails_path
  end

  private

  def dose_params
    params.require(:dose).permit(:name)
  end
end
