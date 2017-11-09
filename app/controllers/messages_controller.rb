class MessagesController < ApplicationController
  def create
    if params[:text] != ""
      message = Message.new(
                            text: params[:text],
                            user_id: current_user.id
                            )
      if message.save
        ActionCable.server.broadcast 'room_channel',
          content: message.text,
          username: message.user.name,
          created_at: message.created_at
      end
    end
  end
end
