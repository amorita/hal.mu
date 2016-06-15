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

end
