class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create, :update]

  def index
    @players = User.all
  end

  def new
    @teams = Team.all
  end

  def create
    user = User.new(
                    name: params[:name],
                    email: params[:email],
                    password: params[:password],
                    password_confirmation: params[:password_confirmation],
                    team_id: params[:team_id]
                    )
    if user.save
      session[:user_id] = user.id
      flash[:success] = "Successfully created an account."
      redirect_to "/flags"
    else
      flash[:warning] = "Incorrect email or password."
      redirect_to "/signup"
    end
  end

  def show
    
  end

  def update
    player = User.find(params[:id])
    lat = params[:latitude].to_f
    lon = params[:longitude].to_f
    player.update(
                  latitude: lat,
                  longitude: lon
                  )
    gon.global.current_user = player
    @players = User.near([player.latitude, player.longitude], 0.01).where.not(id: player.id)
    @bases = Base.near([player.latitude, player.longitude], 0.01)
    @flags = Flag.near([player.latitude, player.longitude], 0.01)
    render json: [@players.to_json(include: [:team, :captures]), @bases.to_json(include: :team), @flags.to_json(include: :team)], status: 200
  end
end
