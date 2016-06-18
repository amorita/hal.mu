class CampSection < ActiveRecord::Base

def fa_class
  case self.pln_class
  when 1
    return "fa-music"
  when 2
    return "fa-cutlery"
  when 3
    return "fa-beer"
  when 4
    return "fa-bed"
  when 5
    return "fa-fire"
  else
    return ""
  end
end

end
