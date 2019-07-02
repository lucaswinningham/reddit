require 'rails_helper'

RSpec.describe VotesController, type: :controller do
  describe 'POST #create' do
    let!(:created_user) { create :user }
    let!(:created_post) { create :post }
    let!(:created_comment) { create :comment }

    context 'with a new vote' do
      let(:post_create_request) do
        new_vote = build :vote, user: nil, voteable: nil
        params = new_vote.attributes.merge post_token: created_post.token
        post :create, params: params
      end
      let(:comment_create_request) do
        new_vote = build :vote, user: nil, voteable: nil
        params = new_vote.attributes.merge comment_token: created_comment.token
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

      it 'should create vote' do
        login created_user
        expect { post_create_request }.to change { Vote.count }.by(1)
        expect { comment_create_request }.to change { Vote.count }.by(1)
      end
    end

    context 'with an existing vote' do
      let(:new_direction) { true }
      let!(:created_post_vote) { create :vote, user: created_user, voteable: created_post }
      let!(:created_comment_vote) { create :vote, user: created_user, voteable: created_comment }
      let(:post_create_request) do
        params = { post_token: created_post.token, direction: new_direction }
        post :create, params: params
      end
      let(:comment_create_request) do
        params = { comment_token: created_comment.token, direction: new_direction }
        post :create, params: params
      end

      it 'should not create vote' do
        login created_user
        expect { post_create_request }.to change { Vote.count }.by(0)
        expect { comment_create_request }.to change { Vote.count }.by(0)
      end

      it 'should update existing vote' do
        login created_user
        post_create_request
        comment_create_request
        expect(created_post_vote.reload.direction).to be true
        expect(created_comment_vote.reload.direction).to be true
      end
    end
  end
end
