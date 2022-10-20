class AccessToken < ApplicationRecord
  belongs_to :user
  belongs_to :client
  validates :token, presence: true
  validates :expires_at, presence: true

  def initialize(params)
    params[:token] ||= SecureRandom.hex(64)
    params[:expires_at] ||= Time.now + 1.minute
    super(params)
  end
end
