class CommentSerializer < BaseSerializer
  attributes :content, :active, :token

  attribute :comments do |comment|
    new comment.comments
  end

  attribute :user_name do |comment|
    comment.user.name
  end

  attribute :votes_count do |comment|
    comment.upvotes - comment.dnvotes
  end
end
