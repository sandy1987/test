class CreateWorkSchedules < ActiveRecord::Migration[5.0]
  def change
    create_table :work_schedules do |t|
      t.datetime :date
      t.string :location
      t.string :role
      t.string :shift_type
      t.string :time_slot_1
      t.string :time_slot_2
      t.string :total_hours
      t.float :amount
      t.integer :user_id

      t.timestamps
    end
  end
end
