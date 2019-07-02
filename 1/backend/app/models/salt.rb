class Salt < ApplicationRecord
  belongs_to :user

  before_create :assign_value

  private

  def assign_value
    self.value = BCrypt::Engine.generate_salt
  end
end
