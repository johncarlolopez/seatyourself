class Reservation < ApplicationRecord
  belongs_to :restaurant
  belongs_to :user

  def validates_reservation
    errors = []
    # Reservation must be between opening_time and closing_time
      opening_time = Time.parse(self.restaurant.opening_time.to_s(:time))
      closing_time = Time.parse(self.restaurant.closing_time.to_s(:time))
      ctime = Time.parse(time.to_s(:time))
      # Need to fix if time goes over 12 PM midnight
      unless (ctime.to_f >= opening_time.to_f) && (ctime.to_f < closing_time.to_f)
        errors << "Reservation must be between #{opening_time} and #{closing_time}"
      end
    # Must be below capacity
      remaining_capacity = self.restaurant.capacity
      self.restaurant.reservations.each {|reservation|
        remaining_capacity -= reservation.party_size
      }
      if party_size > remaining_capacity
        errors << "Sorry we are overbooked"
      end
    # Must be after current time
    puts "Time:#{time}"
    puts "Time:#{DateTime.now}"
      unless time.to_f >= DateTime.now.to_f
        errors << "Sorry, we can't book a reservation in the past"
      end
    return errors
  end

end
