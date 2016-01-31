# -*- coding: utf-8 -*-
class AccountTransactionsController < ApplicationController

layout 'priv'
before_filter :authenticate_user!
skip_before_filter :verify_authenticity_token ,:only=>[:import, :update]
require 'ofx'
include DownloadOfx

def new
end

def import
  file = params[:file]
  data = OFX file
  proc_ofx (data)
  redirect_to '/account_transactions?pages=1'
end

def index
  @page = params[:page].to_i 
  @page = 1 if @page < 1
  @account_transactions = AccountTransaction.where(:transaction_type => ['dep', 'debit']).page(@page).per(20).order('posted_at DESC')
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
