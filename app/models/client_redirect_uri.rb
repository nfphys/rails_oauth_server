class ClientRedirectUri < ApplicationRecord
  belongs_to :client
  validates :uri, presence: :true
end
