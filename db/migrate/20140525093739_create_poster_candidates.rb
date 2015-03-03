class CreatePosterCandidates < ActiveRecord::Migration
  def change
    create_table :poster_candidates do |t|
      t.integer :selection
      t.string :mail
      t.string :user_id

      t.timestamps
    end
  end
end
