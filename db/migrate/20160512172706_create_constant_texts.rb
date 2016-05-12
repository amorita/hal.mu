class CreateConstantTexts < ActiveRecord::Migration
  def change
    create_table :constant_texts do |t|
      t.string :key
      t.text :value

      t.timestamps
    end
  end
end
