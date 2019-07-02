class Comment < ApplicationRecord
  include Activatable
  include Sortable
  include Tokenable
  include Voteable

  belongs_to :user
  belongs_to :commentable, polymorphic: true

  has_many :comments, as: :commentable

  validates :content, presence: true, allow_blank: false, length: { maximum: 10_000 }
end
