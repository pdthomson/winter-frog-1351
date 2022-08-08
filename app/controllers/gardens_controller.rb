class GardensController < ApplicationController

  def show
    @garden = Garden.find(params[:garden_id])
  end
end
