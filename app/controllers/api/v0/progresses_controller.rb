class Api::V0::ProgressesController < ApplicationController
  before_action :set_user
  before_action :set_habit

  def index
    progresses = @habit.progresses.all
    render json: ProgressSerializer.new(progresses)
  end

  def update
    progress = @habit.progresses.find(params[:id])
    progress.update!(progress_params)
    render json: ProgressSerializer.new(progress), status: :ok
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_habit
    @habit = @user.habits.find(params[:habit_id])
  end

  def progress_params
    params.require(:progress).permit(:status)
  end
end
