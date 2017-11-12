class StunsController < ApplicationController
  def create
    @player = User.find(params[:userId])
    flash[:success] = @player.stun(params[:enemyId])
    @players = User.near([@player.latitude, @player.longitude], 0.01).where.not(id: @player.id)
    @flags = Flag.near([@player.latitude, @player.longitude], 30.00)
    render json: [@players.to_json(include: [:team, :captures]), @flags.to_json(include: [:team, :captures]), @player.to_json(include: [:team, :captures, :flags])], status: 200
  end
end
