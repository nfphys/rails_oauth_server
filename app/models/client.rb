class Client < ApplicationRecord
  has_many :redirect_uris, class_name: "ClientRedirectUri"
  has_many :authorization_codes
  has_many :access_tokens
  before_create :set_uuid
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

  def initialize(secret:)
    super(secret_digest: self.class.digest(secret))
  end

  def authenticated?(secret)
    BCrypt::Password.new(secret_digest) == secret
  end

  private 

    def set_uuid 
      while self.id.blank? || self.class.find_by(id: self.id).present?
        self.id = self.class.new_uuid
      end
    end
end
