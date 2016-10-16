class CreateLineConnects < ActiveRecord::Migration
  def change
    create_table :line_connects do |t|
      t.integer :user_id
      t.string :code
      t.string :access_token

      t.timestamps
    end
  end
end
