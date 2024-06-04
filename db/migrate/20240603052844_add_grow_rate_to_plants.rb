class AddGrowRateToPlants < ActiveRecord::Migration[7.1]
  def change
    add_column :plants, :grow_rate, :float
  end
end
