require 'rails_helper'

RSpec.describe VotesController, type: :routing do
  let(:existing_post) { create :post }
  let(:existing_comment) { create :comment }

  let(:post_member_route) { "/posts/#{existing_post.token}/vote" }
  let(:post_member_params) { { post_token: existing_post.token } }

  let(:comment_member_route) { "/comments/#{existing_comment.token}/vote" }
  let(:comment_member_params) { { comment_token: existing_comment.token } }

  it 'does not route to #show' do
    expect(get: post_member_route).not_to be_routable
    expect(get: comment_member_route).not_to be_routable
  end

  it 'routes to #create' do
    expect(post: post_member_route).to route_to('votes#create', post_member_params)
    expect(post: comment_member_route).to route_to('votes#create', comment_member_params)
  end

  it 'does not route to #update via PUT' do
    expect(put: post_member_route).not_to be_routable
    expect(put: comment_member_route).not_to be_routable
  end

  it 'does not route to #update via PATCH' do
    expect(patch: post_member_route).not_to be_routable
    expect(patch: comment_member_route).not_to be_routable
  end

  it 'does not route to #destroy' do
    expect(delete: post_member_route).not_to be_routable
    expect(delete: comment_member_route).not_to be_routable
  end
end
