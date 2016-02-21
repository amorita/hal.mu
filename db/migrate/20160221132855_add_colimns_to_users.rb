class AddColimnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :net_banking_label, :string
  end
end
