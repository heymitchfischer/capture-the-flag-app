class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create]

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
    base = Base.find(params[:base_id])
    if base
      current_user.go_to(base)
    end
    redirect_to "/flags"
  end
end
