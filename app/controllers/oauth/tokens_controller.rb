class Oauth::TokensController < ApplicationController
  skip_before_action :authenticate
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    # ヘッダに client_credentials が含まれるかどうかを検証
    auth_header = request.headers['authorization']
    if auth_header
      client_credentials = decode_client_credentials(auth_header)
      client_id = client_credentials[:id]
      client_secret = client_credentials[:secret]
    end

    # ボディに client_credentials が含まれるかどうかを検証
    if params[:client_id]
      if client_id
        # ヘッダとボディの両方に client_credentials が存在すればエラーを返す
        render json: { error: 'invalid client' }, status: :unauthorized
        return
      end
      client_id = params[:client_id]
      client_secret = params[:client_secret]
    end

    # client_credentials が正しいかどうかを検証
    client = Client.find_by(id: client_id)
    unless client && client.authenticated?(client_secret)
      render json: { error: 'invalid client' }, status: :unauthorized
      return
    end

    case params[:grant_type]
    when 'authorization_code'
      # code が存在するかどうかを検証
      authorization_code = AuthorizationCode.find_by(code: params[:code])
      if !authorization_code
        render json: { error: 'invalid_grant' }, status: :bad_request
        return
      end
      authorization_code.destroy

      # code が正当なクライアントのものであるかどうかを検証
      if authorization_code.client != client
        render json: { error: 'invalid_grant' }, status: :bad_request
        return
      end

      # アクセス・トークンを生成
      access_token = client.access_tokens.create(
        scope: authorization_code.scope,
        user_id: authorization_code.user_id
      )

      render json: {
        access_token: access_token.token,
        token_type: 'Bearer'
      }, status: :ok
      return
    else
      render json: { error: 'unsupported grant type' }, status: :bad_request
      return
    end
  end

  private

    # Authorization ヘッダから client_id と client_secret を取り出す
    def decode_client_credentials(auth_header)
      client_credentials = auth_header[('basic '.length)..].split(":")
      client_id = client_credentials[0]
      client_secret = client_credentials[1]
      { id: client_id, secret: client_secret }
    end
end