class CreateSlipDtls < ActiveRecord::Migration
  def change
    create_table :slip_dtls do |t|
      t.trans_date :date
      t.integer :accounting_item_id
      t.string :memo
      t.integer :amount

      t.timestamps
    end
  end
end
