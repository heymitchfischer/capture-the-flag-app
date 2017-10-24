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
    user = User.find(params[:input])
    lat = params[:latitude].to_d
    lon = params[:longitude].to_d
    user.update(
                            latitude: lat,
                            longitude: lon
                            )
    p params[:longitude]
    p params["latitude"]
    p User.find(1)
    #   ActionCable.server.broadcast 'location_channel', latitude: current_user.latitude, longitude: current_user.longitude
    #   head :ok
    # end
  end
end
