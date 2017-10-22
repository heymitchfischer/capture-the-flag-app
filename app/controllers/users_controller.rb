class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create, :update]

  def index
    @players = User.all
    puts request.remote_ip
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
    response = Unirest.get("http://ip-api.com/json").body
    if current_user 
      current_user.assign_attributes(
                                      latitude: response['lat'],
                                      longitude: response['lon']
                                    )
      current_user.save
    end
    p response['lat']
    #   ActionCable.server.broadcast 'location_channel', latitude: current_user.latitude, longitude: current_user.longitude
    #   head :ok
    # end

    # base = Base.find(params[:base_id])
    # if base
    #   current_user.go_to(base)
    # end
    # # redirect_to "/flags"
  end
end
