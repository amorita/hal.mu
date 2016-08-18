class Campaign < ActiveRecord::Base
  has_many :candidates
end
