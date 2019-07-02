require 'rails_helper'

RSpec.describe PostsController, type: :routing do
  describe 'routing' do
    let(:existing_post) { create :post }
    let(:collection_route) { '/posts' }
    let(:member_route) { "/posts/#{existing_post.to_param}" }
    let(:member_params) { { token: existing_post.to_param } }

    it 'routes to #index' do
      expect(get: collection_route).to route_to('posts#index')
    end

    it 'routes to #show' do
      expect(get: member_route).to route_to('posts#show', member_params)
    end

    it 'routes to #create' do
      expect(post: collection_route).to route_to('posts#create')
    end

    it 'routes to #update via PUT' do
      expect(put: member_route).to route_to('posts#update', member_params)
    end

    it 'routes to #update via PATCH' do
      expect(patch: member_route).to route_to('posts#update', member_params)
    end

    it 'routes to #destroy' do
      expect(delete: member_route).to route_to('posts#destroy', member_params)
    end
  end
end
