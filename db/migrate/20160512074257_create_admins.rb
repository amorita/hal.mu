class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admin_responsibles do |t|
      t.string :name
      t.string :description
      t.string :admin_class

      t.timestamps
    end
  end
end
