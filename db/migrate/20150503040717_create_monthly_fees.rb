class CreateMonthlyFees < ActiveRecord::Migration
  def change
    create_table :monthly_fees do |t|
      t.integer :user_id
      t.integer :year
      t.integer :month
      t.integer :amount

      t.timestamps
    end
  end
end
