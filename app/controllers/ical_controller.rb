class IcalController < ApplicationController

require 'icalendar'

def index
  plns = PracticePln.where("pln_date > curdate() - 360", :include => [:practice_mode, :practice_place]).order(:pln_date, :begining, :mode)
  
  cal = Icalendar::Calendar.new
  
  cal.timezone do |t|
    t.tzid = "Japan"
    t.standard do |s|
      s.tzoffsetfrom = "+0900"
      s.tzoffsetto = "+0900"
      s.tzname = "JST"
      s.dtstart = "19300101T000000"
    end
  end
  
  plns.each do |pln|
    event = Icalendar::Event.new
    p pln.id
    event.dtstart = DateTime.civil_from_format :local, pln.pln_date.year, pln.pln_date.month, pln.pln_date.day, (pln.begining / 100).floor, pln.begining.to_s[-2, 2].to_i
    endhr = (pln.ending / 100).floor
    plnd = 0
    while endhr > 24
      endhr -= 24
      plnd += 1
    end
    event.dtend = DateTime.civil_from_format :local, pln.pln_date.year, pln.pln_date.month, pln.pln_date.day + plnd, endhr, pln.ending.to_s[-2, 2].to_i
    event.summary = "HAL " + pln.practice_mode.name
    event.location = pln.practice_place.place_name + ' (' + pln.room + ')'
    event.url = pln.practice_place.map_url
    event.description = pln.description
    event.uid = pln.uuid
    cal.add_event(event)
  end
  
   render :text => cal.to_ical
end

end
