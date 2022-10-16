require 'rails_helper'

RSpec.describe ClientRedirectUri, type: :model do
  it "有効な状態を持つ" do
    client = Client.create(secret: Client.new_secret)
    redirect_uri = client.redirect_uris.new(uri: "http://example.com")
    expect(redirect_uri).to be_valid
  end

  it "uriが空文字なら無効である" do
    client = Client.create(secret: Client.new_secret)
    redirect_uri = client.redirect_uris.new(uri: "   ")
    expect(redirect_uri).to_not be_valid
  end

  it "client_idが指定されていなければ無効である" do
    redirect_uri = ClientRedirectUri.new(uri: "http://example.com")
    expect(redirect_uri).to_not be_valid
  end
end
