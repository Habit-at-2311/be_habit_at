class AddGrowRateToHabitPlants < ActiveRecord::Migration[7.1]
  def change
    add_column :habit_plants, :grow_rate, :float
  end
end
