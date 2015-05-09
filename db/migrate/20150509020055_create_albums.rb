class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.integer :event_id
      t.integer :user_id
      t.string :url
      t.text :memo

      t.timestamps
    end
  end
end
