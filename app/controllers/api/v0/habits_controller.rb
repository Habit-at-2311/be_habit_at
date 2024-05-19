class Api::V0::HabitsController < ApplicationController
  before_action :set_user

  def index
    habits = @user.habits.all
    render json: HabitSerializer.new(habits)
  end

  def create
    habit = @user.habits.new(habit_params)
    if habit.save
      UpdateHabitStatusJob.set(wait_until: habit.end_datetime.tomorrow.beginning_of_day).perform_later(habit.id)
    end
    render json: HabitSerializer.new(habit), status: :created
  end

  private

  def habit_params
    params.require(:habit).permit(:user_id, :name, :description, :frequency, :custom_frequency, :start_datetime, :end_datetime)
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
