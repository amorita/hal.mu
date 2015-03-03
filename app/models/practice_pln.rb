class PracticePln < ActiveRecord::Base
  self.table_name = 'practice_pln';
  
  belongs_to :practice_mode, :foreign_key => :mode
  belongs_to :practice_place, :foreign_key => :place
  has_many :nontans
end
