class AddRetirementColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :retired, :boolean
  end
end
