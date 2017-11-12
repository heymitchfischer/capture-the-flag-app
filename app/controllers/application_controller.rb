class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  before_action :stunned
  before_action :gon_reset

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def logged_in?
    p !current_user.nil?
  end

  def authenticate_user!
    redirect_to "/login" unless current_user
  end

  def gon_reset
    if current_user
      gon.current_user = current_user
    end
  end

  def stunned
    stunned_players = User.where.not(time_stunned: nil)
    stunned_players.each do |stunned_player|
      if DateTime.now >= stunned_player.time_stunned + 10.minutes
        stunned_player.time_stunned = nil
        stunned_player.save
      end
    end
  end
end
