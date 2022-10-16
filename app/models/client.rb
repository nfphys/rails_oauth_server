class Client < ApplicationRecord
  has_many :redirect_uris, class_name: "ClientRedirectUri", foreign_key: "client_id"
  validates :client_secret_digest, presence: true

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? 
      BCrypt::Engine::MIN_COST :
      BCrypt::Engine.cost

    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_id
    SecureRandom.uuid
  end

  def self.new_secret
    SecureRandom.hex(64)
  end

  def initialize(client_id:, client_secret:)
    super(
      client_id: client_id,
      client_secret_digest: self.class.digest(client_secret),
    )
  end

  def authenticated?(client_secret)
    BCrypt::Password.new(client_secret_digest) == client_secret
  end
end
