class Nontan < ActiveRecord::Base
  belongs_to :practice_pln
  belongs_to :part
  belongs_to :nontan_class
  belongs_to :user
  belongs_to :subs_user, :class_name => "User"
end
