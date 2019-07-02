require 'rails_helper'

RSpec.describe PostsController, type: :routing do
  let(:existing_post) { create :post }

  let(:collection_route) { "/subs/#{existing_post.sub.name}/posts" }
  let(:collection_params) { { sub_name: existing_post.sub.name } }

  let(:member_route) { "/subs/#{existing_post.sub.name}/posts/#{existing_post.to_param}" }

  it 'routes to #index' do
    expect(get: '/posts').to route_to('posts#index')
    expect(get: collection_route).to route_to('posts#index', collection_params)
  end

  it 'does not route to #show' do
    expect(get: member_route).not_to be_routable
  end

  it 'routes to #create' do
    expect(post: collection_route).to route_to('posts#create', collection_params)
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
