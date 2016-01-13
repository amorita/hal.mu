class SlipMapping < ActiveRecord::Base
  has_many :slip
  has_many :account_transaction
end
