class AddStatusAndGrowthColumnsToHabitPlants < ActiveRecord::Migration[7.1]
  def change
    add_column :habit_plants, :status, :integer, null: false, default: 0
    add_column :habit_plants, :days_to_full_growth, :integer
    add_column :habit_plants, :days_to_wilt, :integer
  end
end
