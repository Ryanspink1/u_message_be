class User < ApplicationRecord
  has_secure_password
  enum roll: [:default, :admin]


  validates :email,

            presence: true,
            'valid_email_2/email': true

  validates :email,

            uniqueness: true
end
