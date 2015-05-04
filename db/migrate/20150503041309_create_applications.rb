class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.integer :user_id
      t.text :user_memo
      t.date :starts_at
      t.date :ends_at
      t.integer :application_type_id
      t.integer :part_user_id
      t.text :part_memo
      t.date :part_accepted_at
      t.date :somu_accepted_at

      t.timestamps
    end
  end
end
