class User < ApplicationRecord
  has_secure_password
  enum roll: [:default, :admin]
  has_many :friend_requests, dependent: :destroy
  has_many :pending_friends, through: :friend_requests, source: :friend

  validates :email,

            presence: true,
            'valid_email_2/email': true

  validates :email,

            uniqueness: true
end
