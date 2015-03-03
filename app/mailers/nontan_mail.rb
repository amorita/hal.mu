class NontanMail < ActionMailer::Base
  default from: '"Orchestra HAL 3A system" <pln@hal.mu>'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.nontan.notification.subject
  #
  def notification
    
    @plns = PracticePln.where("date_format(pln_date, '%Y-%m-%d') = date_format(now() + interval 1 day, '%Y-%m-%d')")
    if @plns.length == 0 then
      #mail to: "y@inou.eu", subject: "debug: no record found"
      return
    end
    day = Date.today + 1
    mail to: "orchestra-hal@freeml.com", subject: "練習のお知らせ " + day.month.to_s + '/' + day.day.to_s
#    mail to: "y@inou.eu", subject: "練習のお知らせ " + day.month.to_s + '/' + day.day.to_s
  end

 
end
