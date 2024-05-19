class UpdateHabitStatusJob < ApplicationJob
  queue_as :default

  def perform(habit_id)
    habit = Habit.find_by(habit_id)
    if habit.end_datetime <= Date.current
      habit.update(status: :completed)
    end
  end
end
