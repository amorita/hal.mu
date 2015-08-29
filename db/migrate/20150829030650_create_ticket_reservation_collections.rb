class CreateTicketReservationCollections < ActiveRecord::Migration
  def change
    create_table :ticket_reservation_collections do |t|

      t.timestamps
    end
  end
end
