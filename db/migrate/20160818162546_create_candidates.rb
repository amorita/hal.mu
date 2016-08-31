class CreateCandidates < ActiveRecord::Migration
  def change
    create_table :candidates do |t|
      t.integer :campaign_id
      t.string :name
      t.text :desc
      t.string :image_path

      t.timestamps
    end
  end
end
