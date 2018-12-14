class Conversation < ApplicationRecord
  has_many   :messages
  belongs_to :user
  belongs_to :recipient, foreign_key: :recipient_id, class_name: "User"

  def self.existing(user_id, recipient_id)
    where(user_id: user_id, recipient_id: recipient_id).or(
      where(user_id: recipient_id, recipient_id: user_id)
    )
  end

  def self.find_or_create_conversation(current_user, conversation_params)
    conversation = existing( current_user.id, conversation_params[:recipient_id])[0]
    return conversation if conversation.present?

    create(user_id: current_user.id, recipient_id: conversation_params[:recipient_id])
  end
end
