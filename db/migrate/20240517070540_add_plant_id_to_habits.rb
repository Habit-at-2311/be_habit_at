class AddPlantIdToHabits < ActiveRecord::Migration[7.1]
  def change
    add_reference :habits, :plant, null: false, foreign_key: true
  end
end
