class CreateClubs < ActiveRecord::Migration
  def change
    create_table :clubs do |t|
      t.string :name
      t.text :description
      t.string :code
      t.integer :user_id

      t.timestamps
    end
  end
end
