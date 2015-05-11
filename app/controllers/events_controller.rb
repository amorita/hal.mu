class EventsController < ApplicationController
  before_action :set_event, only: [:edit, :update, :destroy]
 # before_filter :authenticate_user!
  layout 'priv'
  
  def index
  	action = params[:mode]
  	id = params[:id]
  	if !action.nil?
  		if action == 'join'
  			event_att = EventAttendance.new
  			event_att.event_id = id
  			event_att.user_id = current_user.id
  			event_att.save!
        EventMail.new_attendant(Event.find(id), current_user).deliver
  		end
  		if action == 'cancel'
  			EventAttendance.find(id).destroy
  		end
      if action == 'album' && params[:url].present? && params[:url].length > 10
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
        @fids = []
        @future_events.each do |f|
          @fids << f.id
        end
  	@past_events = Event.where("`when` < date(addtime(now(), '7:00'))").order("`when` DESC").limit(5)
    render :layout => false
  end

  def edit
  end

  def new
    @event = Event.new
    @event.alert_days_before = 0
  end

  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id
    respond_to do |format|
      if @event.save
        format.html { redirect_to edit_event_path(@event.id), notice: '作成しました' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { render action: 'edit', notice: '更新しました' }
      else
        format.html { render action: 'edit' }
      end
    end
  end


  def send_album_share_mail(album)
    album.event.event_attendances.each do |att|
      EventMail.share_album(att.user, album).deliver
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end  

    def event_params
      params.require(:event).permit(:title, :description, :when, :ends_at, :alert_days_before, :invite_until)
    end
end
