class Oauth::AuthorizationsController < ApplicationController
  skip_before_action :authenticate

  def new
    @client = Client.find_by(id: params[:client_id])
    unless @client && @client.redirect_uris.find_by(uri: params[:redirect_uri])
      @error_message = 'Invalid Client'
      render 'oauth/authorizations/error'
      return
    end

    @authorization_code = AuthorizationCode.new(
      redirect_uri: params[:redirect_uri],
      state: params[:state],
      client_id: @client.id,
      user_id: session[:user_id],
    )
  end

  def create
    @client = Client.find_by(id: authorization_code_params[:client_id])
    unless @client && @client.redirect_uris.find_by(uri: authorization_code_params[:redirect_uri])
      @error_message = 'Invalid Client'
      render 'oauth/authorizations/error'
      return
    end

    # ユーザーに承認されなかった場合の処理
    if params[:deny]
      uri = URI.parse(authorization_code_params[:redirect_uri])
      uri.query = URI.encode_www_form({
        error: 'access denied'
      })
      redirect_to uri.to_s
      return
    end

    # authorization code を発行
    authorization_code = AuthorizationCode.create(
      authorization_code_params.merge({
        code: AuthorizationCode.new_code
      })
    )

    uri = URI.parse(authorization_code_params[:redirect_uri])
    uri.query = URI.encode_www_form({
      code: authorization_code.code,
      state: authorization_code.state,
    })
    redirect_to uri.to_s
  end

  private 

    def authorization_code_params
      params.require(:authorization_code).permit(
        :redirect_uri,
        :scope,
        :state,
        :client_id,
        :user_id,
      )
    end
end