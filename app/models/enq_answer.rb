class EnqAnswer < ActiveRecord::Base
  belongs_to :enq_age
  belongs_to :enq_gender
  belongs_to :enq_district
  belongs_to :enq_time_req
  belongs_to :enq_source
end
