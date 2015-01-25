class CreateSlots < ActiveRecord::Migration
  def change
    create_table :slots do |t|
      t.text :date
      t.integer :start_hour
      t.integer :end_hour
      t.text :room
      t.text :comment
      t.integer :user

      t.timestamps
    end
  end
end
