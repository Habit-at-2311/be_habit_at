class RemoveDaysToWiltFromHabitPlants < ActiveRecord::Migration[7.1]
  def change
    remove_column :habit_plants, :days_to_wilt, :integer
  end
end
