class User < ApplicationRecord
  has_secure_password

  has_many :reservations

  validates :name, presence: true, uniqueness: true
end
