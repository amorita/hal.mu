class SlipDtl < ActiveRecord::Base
  belongs_to :slip
  belongs_to :accounting_item
end
