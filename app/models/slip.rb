class Slip < ActiveRecord::Base
  has_many :slip_dtls
  has_many :vouchers
  has_many :slip_mappings
  belongs_to :user
  accepts_nested_attributes_for :slip_dtls, allow_destroy: true
  accepts_nested_attributes_for :vouchers, allow_destroy: true
end
