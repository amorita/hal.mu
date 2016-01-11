class CreateAccountingItems < ActiveRecord::Migration
  def change
    create_table :accounting_items do |t|
      t.string :code
      t.string :name
      t.boolean :is_debit

      t.timestamps
    end
  end
end
