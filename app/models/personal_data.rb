class PersonalData < ActiveRecord::Base
  self.table_name = 'users'
  belongs_to :part

  def formal_name
    return self.family_name + ' ' + self.name
  end

  def normal_name
    return self.nickname.nil? ? self.formal_name : nickname
  end

  def long_name
    return formal_name + (self.nickname.nil? ? '' : '(' + nickname + ')')
  end

  def absent?
    fee = MonthlyFee.where(:user_id => self.id, :year => Date.today.year, :month => Date.today.month).first
    result = false
    if !fee.nil?
      result = fee.is_absent
    end
    return result
  end

  def active?
    return !self.absent?
  end

  def absent_on?(date)
    fee = MonthlyFee.where(:user_id => self.id, :year => date.year, :month => date.month).first
    return fee.is_absent
  end

  def active_on?(date)
    return !self.absent_on?(date)
  end

  def valid_on?(date)  
    fee = MonthlyFee.where(:user_id => self.id, :year => date.year, :month => date.month).first
    return !fee.nil?
  end



end