class Nonce < ApplicationRecord
  EXPIRATION_DURATION = 5.minutes

  belongs_to :user

  before_create :assign_value
  before_create :assign_expires_at

  def expired?
    Time.now > Time.at(expires_at)
  end

  private

  def assign_value
    self.value = SecureRandom.base64
  end

  def assign_expires_at
    self.expires_at = EXPIRATION_DURATION.from_now
  end
end
