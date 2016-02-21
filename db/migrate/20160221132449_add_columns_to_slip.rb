class AddColumnsToSlip < ActiveRecord::Migration
  def change
    add_column :slips, :payee_class, :integer
    add_column :slips, :payee_id, :integer
    add_column :slips, :bank_name, :string
    add_column :slips, :bank_branch, :string
    add_column :slips, :bank_account, :string
    add_column :slips, :account_holder, :string
    add_column :slips, :payer_name, :string
  end
end
