class AddPayedColumnToCampAttendances < ActiveRecord::Migration
  def change
    add_column :camp_attendances, :payed, :boolean
  end
end
