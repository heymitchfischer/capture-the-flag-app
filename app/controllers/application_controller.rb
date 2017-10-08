class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :if_stunned

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def if_stunned
    if current_user && current_user.time_stunned != nil
      if DateTime.now >= current_user.time_stunned + 10.minutes
        current_user.time_stunned = nil
        flash[:success] = "You're no longer stunned!"
      end  
    end
  end

  def authenticate_user!
    redirect_to "/login" unless current_user
  end
end
