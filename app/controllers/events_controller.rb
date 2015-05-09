class EventsController < ApplicationController

  before_filter :authenticate_user!
  layout false
  
  def index
  	action = params[:mode]
  	id = params[:id]
  	if !action.nil?
  		if action == 'join'
  			event_att = EventAttendance.new
  			event_att.event_id = id
  			event_att.user_id = current_user.id
  			event_att.save!
  		end
  		if action == 'cancel'
  			EventAttendance.find(id).destroy
  		end
      if action == 'album'
        url = params[:url]
        album = Album.new
        album.event_id = id
        album.user_id = current_user.id
        album.url = url
        album.save!
        send_album_share_mail album
      end
  	end

  	@future_events = Event.where("`when` >= date(addtime(now(), '7:00'))").order(:when)
  	@past_events = Event.where("`when` < date(addtime(now(), '7:00'))").order("`when` DESC").limit(5)
  end

  def send_album_share_mail(album)
    album.event.event_attendances.each do |att|
      EventMail.share_album(att.user, album).deliver
    end
  end
end
