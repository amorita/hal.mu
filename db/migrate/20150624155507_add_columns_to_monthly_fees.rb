class AddColumnsToMonthlyFees < ActiveRecord::Migration
  def change
    add_column :monthly_fees, :is_absent, :boolean
    add_column :monthly_fees, :is_student, :boolean
  end
end
