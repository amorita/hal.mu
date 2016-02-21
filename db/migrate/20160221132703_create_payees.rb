class CreatePayees < ActiveRecord::Migration
  def change
    create_table :payees do |t|
      t.string :name
      t.string :net_banking_label

      t.timestamps
    end
  end
end
