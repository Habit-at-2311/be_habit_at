class Api::V0::HabitsController < ApplicationController
  before_action :set_user

  def index
    habits = @user.habits.all
    render json: HabitSerializer.new(habits)
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
