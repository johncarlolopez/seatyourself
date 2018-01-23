class CreateReservations < ActiveRecord::Migration[5.0]
  def change
    create_table :reservations do |t|
      t.datetime :time
      t.integer :party_size
      t.references :restaurant, foreign_key: true

      t.timestamps
    end
  end
end
