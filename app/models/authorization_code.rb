class AuthorizationCode < ApplicationRecord
  belongs_to :client
  belongs_to :user
  validates :code, presence: true
  validates :redirect_uri, presence: true
  validates :state, presence: true

  def self.new_code
    SecureRandom.urlsafe_base64
  end
end
