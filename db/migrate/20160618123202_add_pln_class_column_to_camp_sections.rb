class AddPlnClassColumnToCampSections < ActiveRecord::Migration
  def change
    add_column :camp_sections, :pln_class, :integer
  end
end
