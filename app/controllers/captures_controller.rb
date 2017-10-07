class CapturesController < ApplicationController
  def create
    flash[:success] = current_user.grab
    redirect_to "/flags"
  end
end
