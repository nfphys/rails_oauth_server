class Oauth::AuthorizationsController < ApplicationController
  skip_before_action :authenticate

  def new
    @client = Client.find_by(id: params[:client_id])
    if !@client 
      redirect_to root_path
      return
    end

    @authorization_code = AuthorizationCode.new(
      redirect_uri: params[:redirect_uri],
      state: params[:state],
      client_id: @client.id,
      user_id: session[:user_id],
    )
  end
end