class AddColumnToNontans < ActiveRecord::Migration
  def change
    add_column :nontans, :user_id, :integer
    add_column :nontans, :subs_user_id, :integer
  end
end
