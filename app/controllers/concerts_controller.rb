class ConcertsController < ApplicationController

def index
  @concerts = Concert.where("date < current_date()")
  render :partial => "index"
end

def show
  @concert = Concert.find(params[:id])
  render :partial => "show"
end

def next
  @concert = Concert.where("date >= current_date()").first
  render :partial => "next"
end

def future
  @concerts = Concert.where("date >= current_date()")
  render :partial => "future"
end
end
