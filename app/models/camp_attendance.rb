class CampAttendance < ActiveRecord::Base
  belongs_to :user

def attends?
  result = false
  30.times do |i|
    if self.send(('section_' + (i + 1).to_s).to_sym) == 1
      result = true
    end
  end
  result
end

def amount
  sections = CampSection.all
  amount = 0
  attend = false
  day_trip = true
  sections.each do |sec|
    if self.send(('section_' + sec.id.to_s).to_sym) == 1
      amount += sec.amount
      attend = true
      if sec.stay
        day_trip = false
      end
    end
  end
  if day_trip && attend
    amount += Camp.order('start_date desc').first.day_trip_fee
  end
  return amount
end

end
