class User < ActiveRecord::Base
  devise :omniauthable
  belongs_to :part

  has_many :social_profiles, dependent: :destroy
  def social_profile(provider)
    social_profiles.select{ |sp| sp.provider == provider.to_s }.first
  end

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

  def self.all
    records = super
    records.where(:retired => false)
  end

  def is_new
    return self.created_at.present? && (self.created_at > 2.month.ago)
  end

end
