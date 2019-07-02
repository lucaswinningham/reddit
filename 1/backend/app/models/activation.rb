class Activation < ApplicationRecord
  belongs_to :user

  attr_reader :token
  before_create :set_token

  before_create :assign_digest

  def authenticate(token)
    BCrypt::Password.new(digest).is_password?(token) && self
  end

  private

  def set_token
    @token = SecureRandom.hex
  end

  def assign_digest
    self.digest = BCrypt::Password.create token
  end
end
