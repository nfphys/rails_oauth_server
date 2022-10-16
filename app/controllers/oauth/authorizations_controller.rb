class Oauth::AuthorizationsController < ApplicationController
  skip_before_action :authenticate

  def new
  end
end