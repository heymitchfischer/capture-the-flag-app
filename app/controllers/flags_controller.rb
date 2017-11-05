class FlagsController < ApplicationController
  before_action :authenticate_user!

  def index
    Gon.global.current_user = current_user
    @nearby_players = User.near([current_user.latitude, current_user.longitude], 0.01)
    gon.nearby_players = User.near([current_user.latitude, current_user.longitude], 0.01)
    @bases = Base.near([current_user.latitude, current_user.longitude], 0.01)
    @flags = Flag.near([current_user.latitude, current_user.longitude], 0.01)
  end

  def update
    flag = Flag.find(params[:id])
    if current_user.team_id != flag.base.team_id
      flash[:success] = current_user.grab(flag.id)
    else
      flash[:success] = current_user.rescue(flag.id)
    end
    redirect_to "/flags"
  end

  def destroy
    flag = Flag.find(params[:id])
    base = Base.find(params[:base_id])
    original_base = Base.find(flag.base_id)
    capture = flag.captures.where(success: nil).first
    if current_user.has_flag && current_user.team_id == flag.base.team_id
      flash[:success] = current_user.bring_back(flag, base, original_base, capture)
    elsif current_user.has_flag && current_user.team_id != flag.base.team_id
      flash[:success] = current_user.score_point(flag, base, original_base, capture)
    else
      flash[:warning] = "You can't do that."
    end
    redirect_to "/flags"
  end
end