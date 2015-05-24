class AddColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :bank, :string
    add_column :users, :bank_branch, :string
    add_column :users, :bank_account, :string
    add_column :users, :bank_name, :string
  end
end
