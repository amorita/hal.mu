class TicketReservationsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_filter :authenticate_user!
  layout 'priv'

def edit
  @revs = TicketReservationCollection.new
  @revs.ticket_reservations = TicketReservation.where(:user_id => current_user.id);
  5.times {
    tr = TicketReservation.new
    tr.user_id = current_user.id
    @revs.ticket_reservations << tr
  }
end

def update
  params[:ticket_reservations].each do |rev_param|
    rev = TicketReservation.new
    rev.id = rev_param[1][:id]
    rev.name = rev_param[1][:name]
    rev.fname = rev_param[1][:fname]
    rev.name_pron = rev_param[1][:name_pron]
    rev.fname_pron = rev_param[1][:fname_pron]
    rev.num_of_ticket = rev_param[1][:num_of_ticket]
    rev.user_id = current_user.id

    if !rev.num_of_ticket.nil? && rev.num_of_ticket > 0
      unless rev.id.nil?
        r = TicketReservation.find rev.id
        unless r.nil?
          r.destroy!
        end
      end
      rev.save!
    else
      if !rev.id.nil?
        r = TicketReservation.find rev.id
        unless r.nil?
          r.destroy!
        end
      end
    end

  end
  redirect_to '/ticket_reservations/edit'
end

def list
  @tickets = TicketReservation.where(:received => false).order(:fname_pron)
end

def receive
  id = params[:id]
  ticket = TicketReservation.find id
  ticket.received = true
  ticket.save!
  redirect_to '/ticket_reservations/list'
end

end
