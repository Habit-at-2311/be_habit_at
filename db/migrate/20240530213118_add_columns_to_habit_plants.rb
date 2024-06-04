class AddColumnsToHabitPlants < ActiveRecord::Migration[7.1]
  def change
    add_column :habit_plants, :style, :string
    add_column :habit_plants, :stem, :string
    add_column :habit_plants, :seed, :string
    add_column :habit_plants, :petal, :string
    add_column :habit_plants, :leaf, :string
    add_column :habit_plants, :scale, :float
  end
end
