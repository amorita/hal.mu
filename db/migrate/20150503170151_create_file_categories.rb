class CreateFileCategories < ActiveRecord::Migration
  def change
    create_table :file_categories do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
