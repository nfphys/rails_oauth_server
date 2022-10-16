class Client < ApplicationRecord
  before_create :set_uuid 
  validates :secret_digest, presence: true

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? 
      BCrypt::Engine::MIN_COST :
      BCrypt::Engine.cost

    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_secret
    SecureRandom.hex(64)
  end

  def initialize(secret:)
    super(secret_digest: self.class.digest(secret))
  end

  def authenticated?(secret)
    BCrypt::Password.new(secret_digest).is_password?(secret)
  end

  private

    def set_uuid 
      while self.id.blank? || self.class.find_by(id: self.id).present? do 
        self.id = SecureRandom.uuid
      end
    end
end
