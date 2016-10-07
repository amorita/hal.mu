class ZipCode < ActiveRecord::Base

  def self.get_address(zip_code)
    zip_code.gsub!('-', '')
    z = self.where(:zipcode => zip_code).first
    if z.nil?
      return ''
    end
    return z.pref + z.city + z.street
  end


end
