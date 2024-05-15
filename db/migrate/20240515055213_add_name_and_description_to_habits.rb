class AddNameAndDescriptionToHabits < ActiveRecord::Migration[7.1]
  def change
    add_column :habits, :name, :string
    add_column :habits, :description, :string
  end
end
