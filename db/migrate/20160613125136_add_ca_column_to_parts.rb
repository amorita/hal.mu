class AddCaColumnToParts < ActiveRecord::Migration
  def change
    add_column :parts, :concern_absence, :boolean
  end
end
