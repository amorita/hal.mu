class CreateFeeAmounts < ActiveRecord::Migration
  def change
    create_table :fee_amounts do |t|
      t.date :starts_at
      t.date :ends_at
      t.integer :workers
      t.integer :students

      t.timestamps
    end
  end
end
