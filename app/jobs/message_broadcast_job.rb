class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    # payload = Hash.new
    # payload = {conversation_id: message.conversation_id, content: message.content, user:message.user_id}

    ActionCable.server.broadcast(build_conversation_id(message.conversation.id), message)
  end

  def build_conversation_id(id)
    "Conversation-#{id}"
  end
end
