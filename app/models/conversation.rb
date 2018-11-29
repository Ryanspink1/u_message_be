class Conversation < ApplicationRecord
  has_many :messages
  has_many :user_conversations
  has_many :users, through: :user_conversations

  def self.create_conversation(current_user, conversation_params)
     conversation = current_user.conversation.create
     recipient_id = conversation_params[:message_recipient_id]
     UserConversation.create(user_id: recipient_id, conversation_id: conversation.id)
     conversation.message.create(user_id: current_user.id)
  end

end
 
