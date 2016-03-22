module AutoBankTransfer

  require 'selenium-webdriver'

  def execute_bank_transfer(transferee_idx, bank_account_title, amount)
    @headless = Headless.new(dimensions: "1920x1080x24")
    @headless.start
    `export DISPLAY=:99`

    @driver = Selenium::WebDriver.for :firefox
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

    @driver.find_element(:css, "a[title=\"振込・振替\"]").click
    @driver.find_element(:link, "登録済みの口座に振り込む").click

    100.times do |i|
      idx = i + 1
      index_text = @driver.find_element(:xpath, "//div[@id='mainCont']/div/form/div[2]/table/tbody/tr[" + idx.to_s + "]/td[1]").text
      if index_text == transferee_idx
        @driver.find_element(:xpath, "(//a[contains(text(),'選択')])[" + idx.to_s + "]").click
        break
      end
    end

    @driver.find_element(:name, "PAY").clear
    @driver.find_element(:name, "PAY").send_keys amount.to_s
    @driver.find_element(:name, "imgKakunin.y").click
    @driver.find_element(:name, "imgNewFuriKakunin.y").click
    @driver.find_element(:link, "ログアウト").click
    @driver.find_element(:css, "input.formButtonNavi2.leftButton").click
  end
end