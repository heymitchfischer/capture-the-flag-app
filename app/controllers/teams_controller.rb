class TeamsController < ApplicationController
  before_action :authenticate_user!

  def index
    @teams = Team.all
  end

  def show
    @team = Team.find(params[:id])
  end
end
