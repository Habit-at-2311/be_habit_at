class Api::V0::PlantsController < ApplicationController
	def index
		plants = Plant.all

		render json: PlantSerializer.new(plants)
	end

	def create
		plant = Plant.new(plant_params)
		if plant.save
			render json: PlantSerializer.new(plant), status: :ok
		else
			raise ActiveRecord::RecordInvalid
		end
	end

	def update
		plant = Plant.find(params[:id])
		if plant.update(plant_params)
			render json: PlantSerializer.new(plant), status: :ok
		else
			render json: plant.error.as_json(full_messages: true), status: 422
		end
	end

	private

	def plant_params
		params.require(:plant).permit(:style, :stem, :seed, :petal, :leaf, :scale)
	end
end
