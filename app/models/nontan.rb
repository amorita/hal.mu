class Nontan < ActiveRecord::Base
  belongs_to :practice_pln
  belongs_to :part
  belongs_to :nontan_class
end
