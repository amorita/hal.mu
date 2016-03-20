class AccountingItem < ActiveRecord::Base
  def fullname
    return self.code + ': ' + self.name
  end

  def fullname_class
    return self.code + ': ' + (self.is_debit? ? '費用' : '資産') + ': ' + self.name
  end
end
