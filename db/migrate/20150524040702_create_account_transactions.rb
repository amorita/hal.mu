class CreateAccountTransactions < ActiveRecord::Migration
  def change
    create_table :account_transactions do |t|
      t.integer :amount
      t.string :fit_id
      t.string :name
      t.datetime :posted_at
      t.string :transaction_type
      t.integer :user_id

      t.timestamps
    end
  end
end
