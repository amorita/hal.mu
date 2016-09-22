class Part < ActiveRecord::Base
	belongs_to :user
  has_many :users
  has_many :persons, class_name: "PersonalData"

  def section
    case self.id
    when 1, 2
      return '高弦'
    when 3, 4
      return '低弦'
    when 105, 106, 107, 108
      return '木管'
    when 109, 110, 111, 112
      return '金管'
    when 113
      return '打楽器'
    end
  end

  def l_section
    case self.id
    when 1, 2, 3, 4
      return '弦'
    when 105, 106, 107, 108
      return '木管'
    when 109, 110, 111, 112, 113
      return '金管・打楽器'
    end
  end

end

