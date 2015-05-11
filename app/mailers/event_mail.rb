# -*- coding: utf-8 -*-
class EventMail < ActionMailer::Base
  default from: '"Orchestra HAL" <welcome@hal.mu>'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.nontan.notification.subject
  #
  def share_album(user, album)
    @user = user
    @album = album
    mail to: @user.email, subject: album.user.normal_name + "さんが" + album.event.title +  "に写真を追加しました！"
  end

  def send_notif
    personal_datas = PersonalData.where('updated_at is null')
    #personal_datas = PersonalData.where(:id => 124)
    personal_datas.each do |data|
      send_all_unlogin(data).deliver
    end
    true
  end

  def new_attendant(event, user)
    @attendant = user
    @event = event
    mail to: event.user.email, subject: "イベント「" + event.title + "」に参加者が増えました！"
  end
end
