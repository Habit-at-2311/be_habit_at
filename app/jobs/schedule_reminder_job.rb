class ScheduleReminderJob < ApplicationJob
  queue_as :urgent

  def perform
    habits_due_tomorrow = Progress.where(datetime: Date.tomorrow.all_day).pluck(:habit_id)

    habits_due_tomorrow.each do |habit|
      UserMailer.with(user: habit.user, habit: habit).reminder_email.deliver_later
    end
  end
end
