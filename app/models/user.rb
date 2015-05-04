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
end
