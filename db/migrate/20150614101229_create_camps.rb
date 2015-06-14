class CreateCamps < ActiveRecord::Migration
  def change
    create_table :camps do |t|
      t.date :start_date
      t.date :end_date
      t.date :first_poll_start_at
      t.date :fiest_poll_end_at
      t.date :final_poll_start_at
      t.date :final_poll_end_at

      t.timestamps
    end
  end
end
