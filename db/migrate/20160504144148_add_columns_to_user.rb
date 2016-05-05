class AddColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :yelp, :string
    add_column :users, :yahoo, :string
    add_column :users, :bing, :string
    add_column :users, :instagram, :string
    add_column :users, :behance, :string
    add_column :users, :origin, :string
    add_column :users, :blood, :string
    add_column :users, :birthday, :date    
  end
end
