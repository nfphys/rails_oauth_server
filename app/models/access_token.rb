class AccessToken < ApplicationRecord
  belongs_to :user
  belongs_to :client
  validates :token, presence: true
  validates :expires_at, presence: true
end
