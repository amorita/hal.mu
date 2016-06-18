class AddStayColumnToCampSections < ActiveRecord::Migration
  def change
    add_column :camp_sections, :stay, :boolean
  end
end
