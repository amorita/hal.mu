class CreateTicketReservations < ActiveRecord::Migration
  def change
    create_table :ticket_reservations do |t|
      t.integer :user_id
      t.string :esp_name
      t.string :name
      t.string :fname
      t.string :name_pron
      t.string :fname_pron
      t.integer :num_of_ticket
      t.boolean :received
      t.integer :concert_id
      t.integer :ticket_reservation_collection_id

      t.timestamps
    end
  end
end
