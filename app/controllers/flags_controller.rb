class FlagsController < ApplicationController
  before_action :authenticate_user!

  def index
    @nearby_players = User.near([current_user.latitude, current_user.longitude], 0.006)
    @bases = Base.all
    @flags = Flag.near([current_user.latitude, current_user.longitude], 0.006)
  end
end