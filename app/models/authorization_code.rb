class AuthorizationCode < ApplicationRecord
  belongs_to :client
  belongs_to :user

  def self.new_code
    SecureRandom.urlsafe_base64
  end
end
