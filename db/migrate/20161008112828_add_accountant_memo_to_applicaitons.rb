class AddAccountantMemoToApplicaitons < ActiveRecord::Migration
  def change
    add_column :applications, :accountant_memo, :text
  end
end
