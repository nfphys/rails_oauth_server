require 'rails_helper'

RSpec.describe Client, type: :model do
  it "有効な状態をもつ" do 
    client = Client.new(secret: Client.new_secret)
    expect(client).to be_valid
  end

  it "secretが正しければ認証される" do
    secret = Client.new_secret
    client = Client.new(secret: secret)
    expect(client.authenticated?(secret)).to be_truthy
  end

  it "secretが間違っていれば認証されない" do 
    client = Client.new(secret: Client.new_secret)
    expect(client.authenticated?("wrong secret")).to be_falsy
  end
end
