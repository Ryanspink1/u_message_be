class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation
  #
  # before_validation :check_for_thread

  after_create_commit { MessageBroadcastJob.perform_later(self) }

  # def check_for_thread
  #   if self.conversation_id == nil
  #     new_conversation       = User.find(self.user_id).conversations.create.user_conversations.create(user_id: self.second_user)
  #     self.conversation_id   = new_conversation.id
  #     UserConversation.create(conversation: new_conversation)
  #   end
  # end


end
