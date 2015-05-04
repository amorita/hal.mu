class Concert < ActiveRecord::Base
  has_many :concert_programs
end
