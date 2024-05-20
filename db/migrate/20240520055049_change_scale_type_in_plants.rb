class ChangeScaleTypeInPlants < ActiveRecord::Migration[7.1]
  def change
    change_column :plants, :scale, :float
  end
end
