class Timeslot < ApplicationRecord

  belongs_to :reservations
  has_many :restaurants

  def give_timeslot
    

  end

end
