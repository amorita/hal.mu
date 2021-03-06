# -*- coding: utf-8 -*-
class SlipMail < ActionMailer::Base
  default from: '"Orchestra HAL accounting system" <info@hal.mu>'
  def notif(slip)
    @slip = slip
    @accountant = Responsible.where(:name => 'accountant').first
    subject = 'OrchestraHAL 出金伝票の入力がありました'
    mail to: @accountant.user.email, subject: subject
  end
end
