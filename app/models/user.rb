class User < ApplicationRecord
  has_secure_password

  has_many :restaurants
  has_many :reservations
  belongs_to :role

  validates :name, presence: true, uniqueness: true
end
