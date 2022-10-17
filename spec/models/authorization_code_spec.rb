require 'rails_helper'

RSpec.describe AuthorizationCode, type: :model do
  before do
    @client = Client.create(secret: Client.new_secret)
    @user = User.create(
      email: "foo@example.com",
      password: "password",
      password_confirmation: "password",
    )
  end

  it "有効な状態を持つ" do
    authorization_code = @client.authorization_codes.new(
      code: AuthorizationCode.new_code,
      redirect_uri: "http://example.com/oauth/callback",
      state: SecureRandom.urlsafe_base64,
      user_id: @user.id,
    )
    expect(authorization_code).to be_valid
  end
end
