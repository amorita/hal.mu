class ApplicationMail < ActionMailer::Base
  default from: '"Orchestra HAL" <welcome@hal.mu>'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.nontan.notification.subject
  #
  def notification(app_id)
    @app = Application.find(app_id)
    mail to: @app.user.part.user.email, subject: "[Orchestra HAL] パートに届け出がありました"
  end

  def president(app_id)
    @app = Application.find(app_id)
    @users = Responsible.where(:name => 'president')
    address = []
    @users.each do |user|
      p user
      address << user.user.email
    end
    mail to: address, subject: "[Orchestra HAL] パートリーダーが届け出を承認しました。"
  end
 
  def somu(app_id)
    @app = Application.find(app_id)
    @users = Responsible.where(:name => 'somu')
    address = []
    @users.each do |user|
      p user
      address << user.user.email
    end
    mail to: address, subject: "[Orchestra HAL] 団長が届け出を承認しました。"
  end
 
end
