class AddColumnToSocialProfile < ActiveRecord::Migration
  def change
    add_column :social_profiles, :access_token, :string
    add_column :social_profiles, :access_secret, :string
  end
end
