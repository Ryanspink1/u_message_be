class ConversationChannel < ApplicationCable::Channel

  def subscribed
    if params[:conversation_id].present?
      stream_from("Conversation-#{params[:conversation_id]}")
    end
  end

  def unsubscribed
    stop_all_streams
  end

end
