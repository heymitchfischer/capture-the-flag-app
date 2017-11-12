class FlagsController < ApplicationController
  before_action :authenticate_user!, except: [:update, :destroy]

  def index
    @nearby_players = User.near([current_user.latitude, current_user.longitude], 0.01)
    gon.nearby_players = User.near([current_user.latitude, current_user.longitude], 0.01)
    @bases = Base.near([current_user.latitude, current_user.longitude], 0.01)
    @flags = Flag.near([current_user.latitude, current_user.longitude], 0.01)
  end

  def update
    @player = User.find(params[:userId])
    flag = Flag.find(params[:flagId])
    if @player.team_id != flag.team_id
      flash[:success] = @player.grab(flag.id)
    else
      flash[:success] = @player.retrieve(flag.id)
    end
    @bases = Base.near([@player.latitude, @player.longitude], 30)
    @flags = Flag.near([@player.latitude, @player.longitude], 30)
    render json: [@bases.to_json(include: :team), @flags.to_json(include: [:team, :captures]), @player.to_json(include: [:team, :captures, :flags])], status: 200
  end

  def destroy
    flag = Flag.find(params[:flagId])
    base = Base.find(params[:baseId])
    @player = User.find(params[:userId])
    original_base = Base.find(flag.base_id)
    capture = flag.captures.where(success: nil).first
    if @player.has_flag && @player.team_id == flag.base.team_id
      flash[:success] = @player.bring_back(flag, base, original_base, capture)
    elsif @player.has_flag && @player.team_id != flag.base.team_id
      flash[:success] = @player.score_point(flag, base, original_base, capture)
    else
      flash[:warning] = "You can't do that."
    end
    @bases = Base.near([@player.latitude, @player.longitude], 30)
    @flags = Flag.near([@player.latitude, @player.longitude], 30)
    render json: [@bases.to_json(include: :team), @flags.to_json(include: [:team, :captures]), @player.to_json(include: [:team, :captures, :flags])], status: 200
  end
end