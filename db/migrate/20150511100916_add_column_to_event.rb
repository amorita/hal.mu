class AddColumnToEvent < ActiveRecord::Migration
  def change
    add_column :events, :invite_until, :date
    add_column :events, :alert_days_before, :integer
    add_column :events, :ends_at, :date
  end
end
