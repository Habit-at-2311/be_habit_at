class Api::V0::PlantsController < ApplicationController
	def index
		plants = Plant.all

		render json: PlantSerializer.new(plants)
	end

	def create
		plant = Plant.new(plant_params)
		if plant.save
			render json: PlantSerializer.new(user), status: :ok
		else
			raise ActiveRecord::RecordInvalid
		end
	end

	private

	def plant_params
		params.require(:plant).permit(:style, :stem, :seed, :petal, :leaf, :scale)
	end
end
