class AddColumnToApplications < ActiveRecord::Migration
  def change
    add_column :applications, :president_accepted_at, :date
    add_column :applications, :president_memo, :text
  end
end
