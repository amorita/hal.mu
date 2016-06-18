class AddDtfColumnToCamp < ActiveRecord::Migration
  def change
    add_column :camps, :day_trip_fee, :integer
  end
end
