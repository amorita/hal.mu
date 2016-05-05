class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :disclosed_phone, :string
    add_column :users, :mobile_mail, :string
    add_column :users, :pc_mail, :string
    add_column :users, :job, :string
    add_column :users, :grad_school, :string
    add_column :users, :major, :string
    add_column :users, :favorite, :string
    add_column :users, :facebook, :string
    add_column :users, :twitter, :string
    add_column :users, :mixi, :string
    add_column :users, :github, :string
    add_column :users, :googleplus, :string
    add_column :users, :tumblr, :string
    add_column :users, :linkedin, :string
    add_column :users, :flickr, :string
    add_column :users, :ameba, :string
    add_column :users, :hatena, :string
    add_column :users, :line, :string
  end
end
