class PostSerializer < BaseSerializer
  attributes :title, :url, :body, :active, :token

  attribute :sub_name do |post|
    post.sub.name
  end

  attribute :user_name do |post|
    post.user.name
  end

  attribute :votes_count do |post|
    post.upvotes - post.dnvotes
  end
end
