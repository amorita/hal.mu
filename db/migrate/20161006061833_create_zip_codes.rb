class CreateZipCodes < ActiveRecord::Migration
  def change
    create_table :zip_codes do |t|
      t.string :jiscode
      t.string :zipcode_old
      t.string :zipcode
      t.string :pref_kana
      t.string :city_kana
      t.string :street_kana
      t.string :pref
      t.string :city
      t.string :street
      t.boolean :flag1
      t.boolean :flag2
      t.boolean :flag3
      t.boolean :flag4
      t.boolean :flag5
      t.boolean :flag6

      t.timestamps
    end
  end
end
