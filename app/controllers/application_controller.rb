class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  before_action :if_stunned
  before_action :gon_reset

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def logged_in?
    p !current_user.nil?
  end

  def if_stunned
    if current_user && current_user.time_stunned != nil
      if DateTime.now >= current_user.time_stunned + 10.minutes
        current_user.time_stunned = nil
        current_user.save
        flash[:success] = "You're no longer stunned!"
      end  
    end
  end

  def authenticate_user!
    redirect_to "/login" unless current_user
  end

  def gon_reset
    if current_user
      gon.current_user = current_user
      p "Gon_Resent finished"
    end
  end
end
