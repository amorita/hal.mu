class CampController < ApplicationController
  layout 'priv'
  before_filter :authenticate_user!

  def edit
    @camp = Camp.all.first
  end

  def update
    camp = Camp.find 1
    camp_p = params[:camp]

    camp.start_date = camp_p[:start_date]
    camp.end_date = camp_p[:end_date]
    camp.first_poll_start_at = camp_p[:first_poll_start_at]
    camp.fiest_poll_end_at = camp_p[:fiest_poll_end_at]
    camp.final_poll_start_at = camp_p[:final_poll_start_at]
    camp.final_poll_end_at = camp_p[:final_poll_end_at]
    camp.day_trip_fee = camp_p[:day_trip_fee]

    camp.save!

    CampSection.destroy_all
    (1..30).each do |i|
      sec_p = params["sections" + i.to_s]
      
      if sec_p[:title].empty? 
        next
      end

      s = CampSection.new

      s.id = i
      s.pln_date = sec_p[:pln_date]
      s.title = sec_p[:title]
      s.pln_class = sec_p[:pln_class]
      s.amount = sec_p[:amount]
      s.memo = sec_p[:memo]
      s.start_at = sec_p[:start_at]
      s.end_at = sec_p[:end_at]
      s.stay = true if s.pln_class == 4

      s.save!
    end

    redirect_to action: 'edit'
  end
end