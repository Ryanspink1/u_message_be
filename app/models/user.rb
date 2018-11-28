class User < ApplicationRecord
  has_secure_password

  enum role: [:default, :admin]

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :messages
  has_many :user_conversations
  has_many :conversations, through: :user_conversations

  validates :email,

            presence: true,
            'valid_email_2/email': true

  validates :email,

            uniqueness: true

  def self.approved(current_user)
    select(:id, :email).
    joins(
          "INNER JOIN friendships
           ON users.id = friendships.user_id
           WHERE friendships.friend_id = #{current_user.id}
           AND friendships.approved=1"
         )
  end

  def self.unapproved(current_user)
    select(:id, :email).
    joins(
          "INNER JOIN friendships
           ON users.id = friendships.friend_id
           WHERE friendships.user_id = #{current_user.id}
           AND friendships.approved=0"
         )
  end
end
