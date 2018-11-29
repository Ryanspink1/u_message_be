class Friendship < ApplicationRecord
  enum approved: [:no, :yes]

  belongs_to :user
  belongs_to :friend, class_name: 'User'

  scope :friends, -> { where( approved: 'yes' ) }
  scope :unapproved, -> { where( approved: 'no' ) }

  after_update :reciprocal_friendship

  validate :no_duplicate_friend_requests

  validates :user_id,
            :friend_id,
            :approved,

            presence: true

  validates :user_id,

            uniqueness: { scope: :friend_id}

  validates :approved, inclusion: { in: ['yes', 'no'] }

  def no_duplicate_friend_requests
    if Friendship.exists?(user_id: self.friend_id, friend_id: self.user_id) && approved == "no"
      errors.add(:friendship, "cannot have duplicate friend_request")
    end
  end

  def reciprocal_friendship
    if approved == "yes"
      Friendship.create(user_id: friend_id, friend_id: user_id, approved:"yes")
    end
  end

  def self.delete_pair(friendship)
    Friendship.find_by(user_id: friendship.friend_id, friend_id:friendship.user_id).delete if friendship.approved == 'yes'
    friendship.delete
  end
end
