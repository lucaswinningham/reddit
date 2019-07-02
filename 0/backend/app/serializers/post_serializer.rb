class PostSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :url, :body, :active, :token, :created_at

  attribute :sub_name do |post|
    post.sub.name
  end

  attribute :user_name do |post|
    post.user.name
  end
end
