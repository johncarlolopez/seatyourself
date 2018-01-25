class AddTimeslotsToReservations < ActiveRecord::Migration[5.0]
  def change
    add_column :reservations, :timeslot_id, :integer
  end
end
