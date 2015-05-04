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

 
end
