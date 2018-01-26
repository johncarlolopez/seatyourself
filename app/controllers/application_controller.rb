class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def ensure_login
    if !session[:user_id]
      flash[:alert] = ["You must be logged in!"]
      redirect_to root_path
    end
  end

end
