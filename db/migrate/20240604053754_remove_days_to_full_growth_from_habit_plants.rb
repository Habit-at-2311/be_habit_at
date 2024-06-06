class RemoveDaysToFullGrowthFromHabitPlants < ActiveRecord::Migration[7.1]
  def change
    remove_column :habit_plants, :days_to_full_growth, :integer
  end
end
