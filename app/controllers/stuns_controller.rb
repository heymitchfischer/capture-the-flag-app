class StunsController < ApplicationController
  def create
    flash[:success] = current_user.stun(params[:id])
    redirect_to "/flags"
  end
end
