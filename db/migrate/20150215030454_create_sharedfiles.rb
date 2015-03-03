class CreateSharedfiles < ActiveRecord::Migration
  def change
    create_table :sharedfiles do |t|
      t.string :filepath
      t.text :description
      t.integer :category
      t.string :uploader
      t.string :name

      t.timestamps
    end
  end
end
