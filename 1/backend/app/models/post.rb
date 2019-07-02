class Post < ApplicationRecord
  include Activatable
  include Sortable
  include Tokenable
  include Voteable

  validates :title, presence: true, allow_blank: false, length: { maximum: 256 }

  validates :body, length: { maximum: 10_000 }

  validates :url, uniqueness: true, format: { with: URI::DEFAULT_PARSER.make_regexp }

  belongs_to :sub

  belongs_to :user

  has_many :comments, as: :commentable
end
