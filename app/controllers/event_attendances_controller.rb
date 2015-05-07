class EventAttendancesController < ApplicationController
  before_filter :authenticate_user!

  def create
  	event_att = EventAttendance.new
  	event_att.event_id = params[:id]
  	event_att.user_id = current_user.id
  	event_att.save!
  end

  def delete
  	EventAttendance.find(params[:id]).destroy!
  end


end
