class User < ApplicationRecord
  has_secure_password

  has_many :reservations

  validates :name, presence: true, uniqueness: true

  def add_loyalty(points)
    loyalty_points = 0 unless loyalty_points
    loyalty_points += points
    self.update(loyalty_points: loyalty_points)
    return true
  end
end
