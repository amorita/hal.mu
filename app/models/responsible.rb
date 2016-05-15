class Responsible < ActiveRecord::Base
	belongs_to :user
  belongs_to :admin_responsible, :foreign_key => "name", :primary_key => "name"
end
