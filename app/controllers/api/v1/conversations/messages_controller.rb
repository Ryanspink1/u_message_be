class Api::V1::Conversations::MessagesController < ApplicationController
  before_action :authenticate_user

  def index
    conversation = Conversation.find(message_params[:conversation_id])
    if @messages = conversation.messages.order(:created_at)
      render json: @messages, status: 200
    else
      render json: @messages.errors
    end
  end

private

  def message_params
    params.permit(:conversation_id)
  end
end
