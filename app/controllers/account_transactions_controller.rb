# -*- coding: utf-8 -*-
class AccountTransactionsController < ApplicationController

layout 'priv'
before_filter :authenticate_user!
skip_before_filter :verify_authenticity_token ,:only=>[:import, :update]
require 'ofx'
require 'headless'
require 'selenium-webdriver'

def new
end

def import
  file = params[:file]
  data = OFX file
  proc_ofx (data)
  redirect_to '/account_transactions?pages=1'
end

def download
  dl_path = "/tmp/selenium-webdriver"

  @headless = Headless.new(dimensions: "1920x1080x24")
  @headless.start
  `export DISPLAY=:99`
  profile = Selenium::WebDriver::Firefox::Profile.new
  profile['intl.accept_languages'] = "ja"
  profile['general.useragent.locale'] = "ja-JP"
  profile['browser.download.dir'] = dl_path
  profile['browser.download.folderList'] = 2
  profile['browser.helperApps.neverAsk.saveToDisk'] = 'application/x-ofx'
  @driver = Selenium::WebDriver.for :firefox, :profile => profile
  @base_url = "https://direct.smbc.co.jp"
  @accept_next_alert = true
  @driver.manage.timeouts.implicit_wait = 30
  @verification_errors = []

  bank_account_userid1 = ConstantValue.where(:key => 'bank_account_userid1').first.value
  bank_account_userid2 = ConstantValue.where(:key => 'bank_account_userid2').first.value
  bank_account_pin = ConstantValue.where(:key => 'bank_account_pin').first.value
  bank_account_label = ConstantValue.where(:key => 'bank_account_label').first.value

  @driver.get(@base_url + "/aib/aibgsjsw5001.jsp")
  @driver.find_element(:id, "USRID1").clear
  @driver.find_element(:id, "USRID1").send_keys bank_account_userid1
  @driver.find_element(:id, "USRID2").clear
  @driver.find_element(:id, "USRID2").send_keys bank_account_userid2
  @driver.find_element(:id, "PASSWORD").clear
  @driver.find_element(:id, "PASSWORD").send_keys bank_account_pin
  @driver.find_element(:name, "bLogon.y").click
  @driver.find_element(:link, bank_account_label).click
  @driver.find_element(:id, "DownloadOFX").click
  @driver.find_element(:link, "ログアウト").click
  @driver.find_element(:css, "input.formButtonNavi2.leftButton").click

  @driver.quit
  @headless.destroy

  files = `ls #{dl_path}/*.ofx -t`.split "\n"
  files.each do |filepath|
    file = File.stat filepath
    data = OFX file
    proc_ofx data
    File.delete filepath
  end
end

def proc_ofx
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
