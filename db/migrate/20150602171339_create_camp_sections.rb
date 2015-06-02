class CreateCampSections < ActiveRecord::Migration
  def change
    create_table :camp_sections do |t|
      t.date :pln_date
      t.string :title
      t.text :memo
      t.integer :amount
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
  end
end
