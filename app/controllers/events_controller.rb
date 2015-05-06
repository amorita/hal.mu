class EventsController < ApplicationController

  before_filter :authenticate_user!
  layout false
  
  def index
  	@future_events = Event.where('`when` >= current_date()').order(:when)
  	@past_events = Event.where('`when` < current_date()').order("`when` DESC").limit(5)
  end

end
