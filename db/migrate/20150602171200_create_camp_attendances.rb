class CreateCampAttendances < ActiveRecord::Migration
  def change
    create_table :camp_attendances do |t|
      t.integer :user_id
      t.boolean :by_car
      t.text :memo
      t.integer :section_1
      t.integer :section_2
      t.integer :section_3
      t.integer :section_4
      t.integer :section_5
      t.integer :section_6
      t.integer :section_7
      t.integer :section_8
      t.integer :section_9
      t.integer :section_10
      t.integer :section_11
      t.integer :section_12
      t.integer :section_13
      t.integer :section_14
      t.integer :section_15
      t.integer :section_16
      t.integer :section_17
      t.integer :section_18
      t.integer :section_19
      t.integer :section_20
      t.integer :section_21
      t.integer :section_22
      t.integer :section_23
      t.integer :section_24
      t.integer :section_25
      t.integer :section_26
      t.integer :section_27
      t.integer :section_28
      t.integer :section_29
      t.integer :section_30

      t.timestamps
    end
  end
end
