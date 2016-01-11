class AccountingItem < ActiveRecord::Base
  def fullname
    return self.code + ': ' + self.name
  end
end
