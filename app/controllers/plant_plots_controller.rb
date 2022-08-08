class PlantPlotsController < ApplicationController

  def delete
    plant = PlantPlot.find_by(plot_id: params[:plot_id], plant_id: params[:plant_id])
    plant.destroy
    redirect_to '/plots'
  end
end
