class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :name
      t.text :desc
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
  end
end
