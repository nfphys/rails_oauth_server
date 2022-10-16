class SessionsController < ApplicationController
  skip_before_action :authenticate, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: user_params[:email])
    if @user&.authenticate(user_params[:password]) 
      log_in @user
    else
      redirect_to new_session_path 
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end

  private 

    def user_params 
      params.require(:user).permit(:email, :password)
    end
end
