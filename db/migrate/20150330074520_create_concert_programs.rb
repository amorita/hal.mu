class CreateConcertPrograms < ActiveRecord::Migration
  def change
    create_table :concert_programs do |t|
      t.integer :concert_id
      t.integer :order
      t.string :composer
      t.string :name
      t.text :note
      t.string :writer
      t.string :file

      t.timestamps
    end
  end
end
