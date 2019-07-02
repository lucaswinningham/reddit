require 'rails_helper'

RSpec.describe CommentsController, type: :routing do
  let(:existing_post) { create :post }
  let(:existing_comment) { create :comment, commentable: existing_post }

  let(:post_collection_route) { "/posts/#{existing_post.token}/comments" }
  let(:post_collection_params) { { post_token: existing_post.token } }

  let(:comment_collection_route) { "/comments/#{existing_comment.token}/comments" }
  let(:comment_collection_params) { { comment_token: existing_comment.token } }

  let(:member_route) { "/comments/#{existing_comment.to_param}" }

  it 'routes to #index' do
    expect(get: post_collection_route).to route_to('comments#index', post_collection_params)
    expect(get: comment_collection_route).to route_to('comments#index', comment_collection_params)
  end

  it 'does not route to #show' do
    expect(get: member_route).not_to be_routable
  end

  it 'routes to #create' do
    expect(post: post_collection_route).to route_to('comments#create', post_collection_params)
    expect(post: comment_collection_route).to route_to('comments#create', comment_collection_params)
  end

  it 'does not route to #update via PUT' do
    expect(put: member_route).not_to be_routable
  end

  it 'does not route to #update via PATCH' do
    expect(patch: member_route).not_to be_routable
  end

  it 'does not route to #destroy' do
    expect(delete: member_route).not_to be_routable
  end
end
