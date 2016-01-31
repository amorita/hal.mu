class CreateConstantValue < ActiveRecord::Migration
  def change
    create_table :constant_values do |t|
      t.string :key
      t.string :value

      t.timestamps
    end
  end
end
