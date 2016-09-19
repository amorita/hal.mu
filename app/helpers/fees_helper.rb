module FeesHelper

  def get_terms
    last_cutoff = FeeCutoff.order('cutoff_date DESC').first
    year = last_cutoff.cutoff_date.year
    month = last_cutoff.cutoff_date.month
    terms = []
    15.times do |i|
      term = {}
      m = month + i
      unless m > 12
        term[:month] = m
        term[:year] = year
      else
        term[:month] = m - 12
        term[:year] = year + 1
      end
      terms << term
    end
    return terms
  end

  def get_fee_diff(user)
    calc = VFeeCalc.where(:user_id => user.id).first
    debt = 0
      get_terms.each do |term|
        if Date.today.month <= term[:month] && Date.today.year <= term[:year]
          break
        end
        fee = MonthlyFee.where(:user_id => calc.user.id, :year => term[:year], :month => term[:month]).first
        if fee.nil?
          debt += 0
        else
          debt += fee.amount
        end
      end
    diff = calc.amount - debt
    return diff
  end
end
