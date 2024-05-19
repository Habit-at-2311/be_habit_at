class AddCustomFrequencyFromHabits < ActiveRecord::Migration[7.1]
  def change
    add_column :habits, :custom_frequency, :jsonb, default: {
      'Monday': false,
      'Tuesday': false,
      'Wednesday': false,
      'Thursday': false,
      'Friday': false,
      'Saturday': false,
      'Sunday': false
    }
  end
end
