class BackfillGrowRateForPlants < ActiveRecord::Migration[7.1]
  def change
    reversible do |dir|
      change_table :plants do |t|
        dir.up do
          Plant.where(grow_rate: nil).find_each do |plant|
            plant.update(grow_rate: 0.4)
          end
        end
      end
    end
  end
end
