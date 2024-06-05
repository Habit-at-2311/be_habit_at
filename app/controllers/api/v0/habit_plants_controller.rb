class Api::V0::HabitPlantsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  def show
    user = User.find(params[:user_id])
    habit = user.habits.find(params[:habit_id])

    habit_plant = habit.habit_plant
    render json: HabitPlantSerializer.new(habit_plant)
  end

  private

  def record_not_found(error)
    render json: { error: error.message }, status: :not_found
  end
end
