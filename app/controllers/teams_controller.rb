class TeamsController < ApplicationController
  before_action :authenticate_user!

  def index
    @teams = Team.order(score: :desc)
    @players= User.order(points: :desc).limit(5)
  end

  def show
    @team = Team.find(params[:id])
  end
end
