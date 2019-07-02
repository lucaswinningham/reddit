class User < ActiveRecord::Base
  include Activatable

  VALID_NAME_REGEX = /\A[A-Za-z0-9_\-]+\Z/.freeze
  validates :name, presence: true, allow_blank: false, uniqueness: true,
                   format: { with: VALID_NAME_REGEX }, length: { minimum: 3, maximum: 20 }

  has_many :posts
  before_deactivate :deactivate_posts

  def to_param
    name
  end

  has_many :comments
  before_deactivate :deactivate_comments

  has_one :salt
  after_create :create_salt

  has_one :nonce

  def authenticate(hashed_password)
    BCrypt::Password.new(password_digest).is_password?(hashed_password) && self
  end

  def hashed_password=(hashed_password)
    self.password_digest = BCrypt::Password.create hashed_password
  end

  def password=(plain_password)
    hashed_password = BCrypt::Engine.hash_secret plain_password, salt.value
    self.password_digest = BCrypt::Password.create hashed_password
  end

  has_one :activation
  after_create :create_activation

  private

  def deactivate_posts
    posts.each(&:deactivate)
  end

  def deactivate_comments
    comments.each(&:deactivate)
  end
end
