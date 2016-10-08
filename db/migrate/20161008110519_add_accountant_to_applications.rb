class AddAccountantToApplications < ActiveRecord::Migration
  def change
    add_column :applications, :accountant_accepted_at, :date
  end
end
