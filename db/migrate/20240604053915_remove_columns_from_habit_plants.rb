class RemoveColumnsFromHabitPlants < ActiveRecord::Migration[7.1]
  def change
    remove_column :habit_plants, :style, :string
    remove_column :habit_plants, :stem, :string
    remove_column :habit_plants, :seed, :string
    remove_column :habit_plants, :petal, :string
    remove_column :habit_plants, :leaf, :string
  end
end
