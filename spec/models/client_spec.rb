require 'rails_helper'

RSpec.describe Client, type: :model do
  it "有効な状態をもつ" do 
    client_id = Client.new_id
    client_secret = Client.new_secret
    client = Client.new(
      client_id: client_id,
      client_secret: client_secret
    )
    expect(client).to be_valid
  end

  it "secretが正しければ認証される" do
    client_id = Client.new_id
    client_secret = Client.new_secret
    client = Client.new(
      client_id: client_id,
      client_secret: client_secret
    )
    expect(client.authenticated?(client_secret)).to be_truthy
  end

  it "secretが間違っていれば認証されない" do 
    client_id = Client.new_id
    client_secret = Client.new_secret
    client = Client.new(
      client_id: client_id,
      client_secret: client_secret
    )
    expect(client.authenticated?("wrong secret")).to be_falsy
  end
end
