class Post < ApplicationRecord
  belongs_to :user
  belongs_to :sub

  validates :title, presence: true, allow_blank: false, length: { maximum: 256 }

  validates :body, length: { maximum: 10_000 }

  validates :url, uniqueness: true, format: { with: URI::DEFAULT_PARSER.make_regexp }

  before_create :activate

  before_create :assign_token

  def to_param
    token
  end

  private

  def activate
    self.active = true
  end

  def assign_token
    self.token = SecureRandom.hex(8) until unique_token?
  end

  def unique_token?
    token && self.class.find_by_token(token).nil?
  end
end
