class AddColumnToConcert < ActiveRecord::Migration
  def change
    add_column :concerts, :supporter, :string
  end
end
