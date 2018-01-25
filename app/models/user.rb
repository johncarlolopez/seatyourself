class User < ApplicationRecord
  has_secure_password

  has_many :restaurants
  has_many :reservations
  belongs_to :role

  validates :name, presence: true, uniqueness: true

  def add_loyalty(points)
    puts "Loyalty before: #{loyalty_points}"
    unless (self.loyalty_points)
      self.loyalty_points = 0
    end
    puts "Loyalty after checking if nil: #{loyalty_points}"
    self.loyalty_points += points
    puts "Loyalty after adding: #{loyalty_points}"
    self.update(loyalty_points: self.loyalty_points)
    return true
  end
end
