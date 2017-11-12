class MessagesController < ApplicationController
  def create
    if params[:text] != ""
      message = Message.new(
                            text: params[:text],
                            user_id: params[:userId]
                            )
      if message.save
        ActionCable.server.broadcast 'room_channel',
          content: message.text,
          username: message.user.name,
          created_at: message.created_at,
          room_id: message.user.team_id
      end
    end
  end
end
