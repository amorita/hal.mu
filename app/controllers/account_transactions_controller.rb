class AccountTransactionsController < ApplicationController

layout 'priv'
before_filter :authenticate_user!
skip_before_filter :verify_authenticity_token ,:only=>[:import, :update]
require 'ofx'

def new
end

def import
  file = params[:file]
  data = OFX file
  data.account.transactions.each do |trans|
    if AccountTransaction.where(:fit_id => trans.fit_id).count == 0
      account_transaction = AccountTransaction.new
      account_transaction.amount = trans.amount_in_pennies / 100
      account_transaction.fit_id = trans.fit_id
      account_transaction.name = trans.name
      account_transaction.posted_at = trans.posted_at + (9 / 24)
      account_transaction.transaction_type = trans.type.to_s
      user = User.where(:bank_name => trans.name).first if trans.type == :dep
      unless user.nil?
        account_transaction.user_id = user.id
      end
      account_transaction.save!
    end
  end
  redirect_to '/account_transactions?pages=1'
end

def index
  @page = params[:pages].to_i - 1
  @account_transactions = AccountTransaction.limit(100).offset(@page * 100).order('posted_at DESC')
  @count = AccountTransaction.all.count
end

def edit
  @account_transaction = AccountTransaction.find(params[:id])
end

  def update
    @account_transaction = AccountTransaction.find(params[:id])
    if @account_transaction.update(account_transaction_params)

      # すべての取引の更新
      AccountTransaction.where(:name => @account_transaction.name).where('user_id is null').each do |trans|
        trans.user_id = @account_transaction.user_id
        trans.save!
      end

      # ユーザ情報の更新
      user = User.find(@account_transaction.user_id)
      user.bank_name = @account_transaction.name
      user.save!

      redirect_to '/account_transactions?pages=1' and return
    else
      render action: 'edit'
    end
  end


private
  def account_transaction_params
    params.require(:account_transaction).permit(:name, :user_id)
  end

end
