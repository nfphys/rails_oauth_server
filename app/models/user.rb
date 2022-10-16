class User < ApplicationRecord
  has_many :authorization_codes
  validates :email,
    presence: true,
    uniqueness: true
    
  has_secure_password
end
