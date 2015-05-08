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
  	end

  	@future_events = Event.where('`when` >= current_date()').order(:when)
  	@past_events = Event.where('`when` < current_date()').order("`when` DESC").limit(5)
  end

end
