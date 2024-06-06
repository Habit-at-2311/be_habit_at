class CreateHabitPlants < ActiveRecord::Migration[7.1]
  def change
    create_table :habit_plants do |t|
      t.references :habit, null: false, foreign_key: true
      t.references :plant, null: false, foreign_key: true
      t.timestamps
    end
  end
end
