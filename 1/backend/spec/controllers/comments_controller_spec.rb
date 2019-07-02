require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:created_comment) { create :comment }

  describe 'GET #index' do
    let(:request_index) { get :index, params: { post_token: created_comment.commentable.token } }

    it 'returns a success response' do
      expect_response(:ok) { request_index }
    end

    it 'renders only comments for the post of given token' do
      create :comment, commentable: create(:post)
      request_index
      expect(response_body.data.count).to eq(1)
      expect(response_body.data.first.id.to_i).to eq(created_comment.id)
    end
  end

  describe 'POST #create' do
    let!(:created_user) { create :user }
    let!(:created_post) { create :post }
    let!(:created_comment) { create :comment }
    let(:post_create_request) do
      new_comment = build :comment, user: nil, commentable: nil
      params = new_comment.attributes.merge post_token: created_post.token
      post :create, params: params
    end
    let(:comment_create_request) do
      new_comment = build :comment, user: nil, commentable: nil
      params = new_comment.attributes.merge comment_token: created_comment.token
      post :create, params: params
    end

    it 'requires authentication' do
      expect_response(:unauthorized) { post_create_request }
      expect_response(:unauthorized) { comment_create_request }
    end

    it 'returns a success response' do
      expect_response(:created) { login(created_user) && post_create_request }
      expect_response(:created) { login(created_user) && comment_create_request }
    end

    it 'should create comment' do
      login created_user
      expect { post_create_request }.to change { Comment.count }.by(1)
      expect { comment_create_request }.to change { Comment.count }.by(1)
    end
  end
end
