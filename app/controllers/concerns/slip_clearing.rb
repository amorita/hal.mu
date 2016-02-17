module SlipClearing
  def executeClearing(transaction)
    slip = nil
    if transaction.transaction_type == 'debit' then
      case transaction.name
      # 支払手数料の処理
      when '振込手数料' then
        slip = getTransferFeeSlip transaction
      end
    end

    if transaction.transaction_type == 'dep' then
      case transaction.name
      when '普通預金利息' then
        slip = getInterestSlip transaction
      end
    end

    if slip.nil?
      slip = findCounter transaction
    end

    # マッピング作成    
    if slip.instance_of?(Array) then
      slip.each do |s|
        map = SlipMapping.new
        map.account_transaction_id = transaction.id
        map.slip_id = s.id
        map.save!
      end
    else
      unless slip.nil?
        map = SlipMapping.new
        map.account_transaction_id = transaction.id
        map.slip_id = slip.id
        map.save!
      end
    end      
  end

  def getTransferFeeSlip(t)
    getSlip(t, AccountingItem.where(:code => 630).first.id)
  end

  def getInterestSlip(t)
    getSlip(t, AccountingItem.where(:code => 900).first.id)
  end

  def getSlip(t, item_id)
    slip = Slip.new
    slip.amount = t.amount * -1
    slip.transferred = true
    dtl = SlipDtl.new
    dtl.amount = t.amount * -1
    dtl.accounting_item_id = item_id
    dtl.memo = t.name
    dtl.trans_date = t.posted_at
    slip.slip_dtls << dtl
    slip.save!
    slip
  end    

  def findCounter(t)
    amount = t.amount * -1
    # 単一の対象
    slips = Slip.find_by_sql("select * from slips where not exists (select 'x' from slip_mappings where slip_id = slips.id) and amount = #{amount}")
    if slips.count == 1 then
      return slips
    end

    # 2つの対象
    slips = []
    slips_a = Slip.find_by_sql("select * from slips where not exists (select 'x' from slip_mappings where slip_id = slips.id) and amount < #{amount}")
    slips_a.each do |s|
      amount_b = amount - s.amount
      slips_b = Slip.find_by_sql("select * from slips where not exists (select 'x' from slip_mappings where slip_id = slips.id) and amount = #{amount_b}")
      if slips_b.count == 1 then
        slips << s
        slips << slips_b[0]
        return slips
      end
    end

    return nil
  end
end


