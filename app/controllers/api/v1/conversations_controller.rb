class Api::V1::ConversationsController < ApplicationController
  before_action :authenticate_user

  def create
    if @conversation = Conversation.find_or_create_conversation(current_user, conversation_params)
      render json: @conversation
    else
      render @conversation.errors
    end
  end

  def find_or_create

  end


private

  def conversation_params
    params.permit(:id, :recipient_id)
  end
end
