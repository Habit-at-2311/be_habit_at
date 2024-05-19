class CreatePlants < ActiveRecord::Migration[7.1]
  def change
    create_table :plants do |t|
      t.string :style
      t.string :stem
      t.string :seed
      t.string :petal
      t.string :leaf
      t.integer :scale

      t.timestamps
    end
  end
end
