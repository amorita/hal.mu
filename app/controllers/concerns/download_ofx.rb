# -*- coding: utf-8 -*-
require "json"
require "selenium-webdriver"

module DownloadOfx

  # before(:each) do
  #   @driver = Selenium::WebDriver.for :firefox
  #   @base_url = "https://direct.smbc.co.jp"
  #   @accept_next_alert = true
  #   @driver.manage.timeouts.implicit_wait = 30
  #   @verification_errors = []
  # end
  
  # after(:each) do
  #   @driver.quit
  #   @verification_errors.should == []
  # end
  
  def execute
    @headless = Headless.new(dimensions: "1920x1080x24")
    @headless.start
    `export DISPLAY=:99`
    profile = Selenium::WebDriver::Firefox::Profile.new
    profile['intl.accept_languages'] = "ja"
    profile['general.useragent.locale'] = "ja-JP"
    profile['browser.download.dir'] = "/tmp/selenium-webdriver"
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
#    @driver.get "https://direct3.smbc.co.jp/servlet/com.smbc.MoneyServlet?redirected=1"
    @driver.find_element(:id, "DownloadOFX").click
    @driver.find_element(:link, "ログアウト").click
    @driver.find_element(:css, "input.formButtonNavi2.leftButton").click

    @driver.quit
    @headless.destroy
  end
  
  # def element_present?(how, what)
  #   ${receiver}.find_element(how, what)
  #   true
  # rescue Selenium::WebDriver::Error::NoSuchElementError
  #   false
  # end
  
  # def alert_present?()
  #   ${receiver}.switch_to.alert
  #   true
  # rescue Selenium::WebDriver::Error::NoAlertPresentError
  #   false
  # end
  
  # def verify(&blk)
  #   yield
  # rescue ExpectationNotMetError => ex
  #   @verification_errors << ex
  # end
  
  # def close_alert_and_get_its_text(how, what)
  #   alert = ${receiver}.switch_to().alert()
  #   alert_text = alert.text
  #   if (@accept_next_alert) then
  #     alert.accept()
  #   else
  #     alert.dismiss()
  #   end
  #   alert_text
  # ensure
  #   @accept_next_alert = true
  # end
end
