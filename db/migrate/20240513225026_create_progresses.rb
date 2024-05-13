class CreateProgresses < ActiveRecord::Migration[7.1]
  def change
    create_table :progresses do |t|
      t.references :habit, null: false, foreign_key: true
      t.integer :status, default: 0
      t.datetime :datetime
      t.timestamps
    end
  end
end
