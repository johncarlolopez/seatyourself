class Reservation < ApplicationRecord
  belongs_to :restaurant
  belongs_to :user

  # def validates_time
  #   # Reservation must be between opening_time and closing_time
  #     opening_time = time.parse(self.restaurant.opening_time.to_s(:time))
  #     closing_time = time.parse(self.restaurant.closing_time.to_s(:time))
  #
  #     if time > opening_time && time < closing_time
  #       return true
  #     else
  #       return "Reservation must be between #{opening_time} and #{closing_time}"
  #   # Must be below capacity
  #
  #   # Must be after current time
  #   end
  # end

end
