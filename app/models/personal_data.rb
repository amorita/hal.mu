class PersonalData < ActiveRecord::Base
  self.table_name = 'users'
  belongs_to :part
end