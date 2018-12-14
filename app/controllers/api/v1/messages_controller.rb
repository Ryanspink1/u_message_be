class Api::V1::MessagesController < ApplicationController

  def create
    message = Message.new(user_id: current_user.id,
                          conversation_id: message_params[:conversation_id],
                          content:message_params[:content])
    if message.save
      render status: 200
    else
      render json: message.errors, status: :bad_request
    end
  end

private

  def message_params
    params.permit(:id, :content, :conversation_id )
  end
end
