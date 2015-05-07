class CreateEventAttendances < ActiveRecord::Migration
  def change
    create_table :event_attendances do |t|
      t.integer :event_id
      t.integer :user_id
      t.text :memo

      t.timestamps
    end
  end
end
