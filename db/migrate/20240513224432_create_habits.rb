class CreateHabits < ActiveRecord::Migration[7.1]
  def change
    create_table :habits do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :frequency, default: 0
      t.datetime :start_datetime
      t.datetime :end_datetime
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
