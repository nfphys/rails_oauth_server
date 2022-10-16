require 'rails_helper'

RSpec.describe User, type: :model do
  it "有効な状態を持つ" do 
    user = User.new(
      email: "foo@example.com",
      password: "password",
      password_confirmation: "password",
    )
    expect(user).to be_valid
  end

  it "emailが存在しなければ無効である" do 
    user = User.new(
      email: "",
      password: "password",
      password_confirmation: "password",
    )
    expect(user).to_not be_valid 
  end

  it "emailが既に登録されていれば無効である" do 
    other_user = User.create(
      email: "foo@example.com",
      password: "password",
      password_confirmation: "password"
    )
    user = User.new(
      email: other_user.email,
      password: "password",
      password_confirmation: "password"
    )
    expect(user).to_not be_valid
  end
end
