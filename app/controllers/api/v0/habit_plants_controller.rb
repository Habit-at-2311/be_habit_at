class Api::V0::HabitPlantsController < ApplicationController
  def show
    user = User.find(params[:user_id])
    habit = user.habits.find(params[:habit_id])

    habit_plant = habit.habit_plant
    render json: HabitPlantSerializer.new(habit_plant)
  end
end
