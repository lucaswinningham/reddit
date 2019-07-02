require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let!(:created_post) { create :post }

  describe 'GET #index' do
    it 'returns a success response' do
      expect_response(:ok) { get :index, params: { sub_name: created_post.sub.name } }
    end

    it 'renders all posts' do
      create :post
      get :index
      expect(response_data.count).to eq(2)
    end

    context 'given a valid sub name' do
      it 'renders only posts for that sub' do
        create :post
        get :index, params: { sub_name: created_post.sub.name }
        expect(response_data.count).to eq(1)
        expect(response_data.first.id.to_i).to eq(created_post.id)
      end
    end

    context 'given an invalid sub name' do
      it 'renders an error' do
        expect_response(:not_found) { get :index, params: { sub_name: 'bogus' } }
      end
    end
  end

  describe 'POST #create' do
    let!(:created_user) { create :user }
    let!(:created_sub) { create :sub }
    let(:create_request) do
      new_post = build :post, user: nil, sub: nil
      params = new_post.attributes.merge sub_name: created_sub.name
      post :create, params: params
    end

    it 'requires authentication' do
      expect_response(:unauthorized) { create_request }
    end

    it 'returns a success response' do
      expect_response(:created) { login(created_user) && create_request }
    end

    it 'should create post' do
      login created_user
      expect { create_request }.to change { Post.count }.by(1)
    end
  end
end
