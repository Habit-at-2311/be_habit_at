class Api::V0::PlantsController < ApplicationController
	def index
		plants = Plant.all

		render json: PlantSerializer.new(plants)
	end
end