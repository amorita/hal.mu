class CreateConcerts < ActiveRecord::Migration
  def change
    create_table :concerts do |t|
      t.string :name
      t.date :date
      t.string :place
      t.string :hall
      t.string :conductor

      t.timestamps
    end
  end
end
