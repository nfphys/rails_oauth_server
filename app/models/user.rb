class User < ApplicationRecord
  has_many :authorization_codes
  has_many :access_tokens
  validates :email,
    presence: true,
    uniqueness: true
    
  has_secure_password
end
