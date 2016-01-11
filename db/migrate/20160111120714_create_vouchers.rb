class CreateVouchers < ActiveRecord::Migration
  def change
    create_table :vouchers do |t|
      t.integer :slip_id
      t.string :file_path

      t.timestamps
    end
  end
end
