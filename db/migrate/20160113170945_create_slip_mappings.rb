class CreateSlipMappings < ActiveRecord::Migration
  def change
    create_table :slip_mappings do |t|
      t.integer :slip_id
      t.integer :account_transaction_id

      t.timestamps
    end
  end
end
