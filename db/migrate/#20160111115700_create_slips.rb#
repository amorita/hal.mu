class CreateSlips < ActiveRecord::Migration
  def change
    create_table :slips do |t|
      t.integer :user_id
      t.integer :amount
      t.integer :slip_dtl_id

      t.timestamps
    end
  end
end
