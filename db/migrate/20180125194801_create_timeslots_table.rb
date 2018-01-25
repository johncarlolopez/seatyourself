class CreateTimeslotsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :timeslots do |t|
      t.datetime :timing
      t.integer :capacity
      t.datetime :day
      t.references :restaurant, foreign_key: true
    end
  end
end
