class ApplicationController < ActionController::Base
  before_action :authenticate 
  helper_method :logged_in?, :current_user 

  private 

    def log_in(user)
      session[:user_id] = user.id
      redirect_to root_path
      flash[:success] = "ログインしました"
    end

    def logged_in?
      !!session[:user_id]
    end

    def current_user 
      return unless session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end

    def authenticate
      return if logged_in?
      redirect_to root_path
      flash[:danger] = "ログインしてください"
    end
end
