class Client < ApplicationRecord
  has_many :redirect_uris, class_name: "ClientRedirectUri", foreign_key: "client_id"
  validates :secret_digest, presence: true

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? 
      BCrypt::Engine::MIN_COST :
      BCrypt::Engine.cost

    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_uuid
    SecureRandom.uuid
  end

  def self.new_secret
    SecureRandom.hex(64)
  end

  def initialize(uuid:, secret:)
    super(
      uuid: uuid,
      secret_digest: self.class.digest(secret),
    )
  end

  def authenticated?(secret)
    BCrypt::Password.new(secret_digest) == secret
  end
end
