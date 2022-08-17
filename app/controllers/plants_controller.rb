class PlantsController < ApplicationController

  def create
    # Create new plant
    @plant = Plant.new(plant_params)
    # plant this plant in a garden
    @garden = Garden.find(params[:garden_id])
    @plant.garden = @garden
    # try to save it
    if @plant.save
      # redirect if saved
      redirect_to garden_path(@garden)
    else
      # render the form again if not
      render 'gardens/show', status: :unprocessable_entity
    end
  end

  def destroy
    @plant = Plant.find(params[:id])
    @plant.destroy
    redirect_to garden_path(@plant.garden), status: :see_other
  end

  private

  def plant_params
    params.require(:plant).permit(:name, :image_url)
  end
end
