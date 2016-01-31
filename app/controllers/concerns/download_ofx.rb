# -*- coding: utf-8 -*-
require "json"
require "selenium-webdriver"
require "ofx"
require "headless"

module DownloadOfx

  def execute
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
end
