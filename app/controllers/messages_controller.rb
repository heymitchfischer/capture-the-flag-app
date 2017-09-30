class MessagesController < ApplicationController
  def create
    message = Message.new(
                          text: params[:text],
                          user_id: current_user.id
                          )
    message.save
    redirect_to "/teams/#{current_user.team.id}"
  end
end
