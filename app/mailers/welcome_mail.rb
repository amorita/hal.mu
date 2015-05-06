class WelcomeMail < ActionMailer::Base
  default from: '"Orchestra HAL" <welcome@hal.mu>'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.nontan.notification.subject
  #
  def welcome(new_id)
    @personal_data = PersonalData.where(:id => new_id).first
    mail to: @personal_data.email, subject: "Orchestra HALヘようこそ！"
  end

  def send_all_unlogin
    personal_datas = PersonalData.where('updated_at is null')
    #personal_datas = PersonalData.where(:id => 124)
    personal_datas.each do |data|
      @personal_data = data
      p data.family_name
      mail to: data.email, subject: "【重要】Orchestra HAL 団員専用サイトからお知らせ"
    end
  end
end
