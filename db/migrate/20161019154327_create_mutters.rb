class CreateMutters < ActiveRecord::Migration
  def change
    create_table :mutters do |t|
      t.integer :user_id
      t.string :message

      t.timestamps
    end
  end
end
