class TicketReservation < ActiveRecord::Base
  belongs_to :ticket_reservation_collection
  belongs_to :user
end
