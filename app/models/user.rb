# An application's user
class User < ApplicationRecord
  has_secure_token

  validates(
    :email,
    presence: true,
    uniqueness: true,
    format: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  )

  validates :name, presence: true
end
