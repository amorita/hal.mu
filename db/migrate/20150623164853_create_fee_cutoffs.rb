class CreateFeeCutoffs < ActiveRecord::Migration
  def change
    create_table :fee_cutoffs do |t|
      t.date :cutoff_date

      t.timestamps
    end
  end
end
