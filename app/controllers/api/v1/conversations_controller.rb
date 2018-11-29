class Api::V1::ConversationsController < ApplicationController
  before_action :authenticate_user

  def create
    if Conversation.create_conversation(current_user, conversation_params)
      render
  end


  private

  def conversation_params
    params.permit(:id, :message_recipient_id, :message_text)
  end
end
