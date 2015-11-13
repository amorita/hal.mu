# -*- coding: utf-8 -*-
class RehearsalNotif < ActionMailer::Base
  default from: '"Haruwo" <pln@hal.mu>'
  def notif(pln, params)
    @pln = pln
    @header = params[:header_text]
    @footer = params[:footer_text]
    subject = @pln.pln_date.month.to_s + '/' + @pln.pln_date.day.to_s + 'の' + @pln.practice_mode.name + 'について'
    mail to: "orchestra-hal@freeml.com", subject: subject
#    mail to: "y@inou.eu", subject: subject
  end
end
