require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:created_post) { create :post }

  describe 'GET #index' do
    it 'returns a success response' do
      expect_response(:ok) { get :index }
    end
  end

  describe 'GET #show' do
    context 'with valid indentifier' do
      it 'returns a success response' do
        expect_response(:ok) do
          params = { token: created_post.to_param }
          get :show, params: params
        end
      end
    end

    context 'with invalid indentifier' do
      it 'returns an error response' do
        expect_response(:not_found) do
          params = { token: '' }
          get :show, params: params
        end
      end
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:request_create) do
        new_post = build :post
        params = { post: new_post.as_json }
        post :create, params: params
      end

      it 'blah' do
        request_create
      end

      it 'returns a success response' do
        expect_response(:created) { request_create }
      end

      it 'creates the requested post' do
        expect { request_create }.to change { Post.count }.by(1)
      end
    end

    context 'with invalid params' do
      it 'returns an error response' do
        expect_response(:unprocessable_entity) do
          new_post = build :post, title: '', url: ''
          params = { post: new_post.as_json }
          post :create, params: params
        end
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid indentifier' do
      context 'with valid params' do
        let(:new_title) { 'other' }
        let(:new_url) { 'http://www.other.com' }
        let(:request_update) do
          post_patch = build :post, title: new_title, url: new_url
          params = { token: created_post.to_param, post: post_patch.as_json }
          put :update, params: params
        end

        it 'returns a success response' do
          expect_response(:ok) { request_update }
        end

        it 'updates the requested post' do
          request_update

          created_post.reload
          assert_equal new_title, created_post.title
          assert_equal new_url, created_post.url
        end
      end

      context 'with invalid params' do
        it 'returns an error response' do
          expect_response(:unprocessable_entity) do
            post_patch = build :post, title: '', url: ''
            params = { token: created_post.to_param, post: post_patch.as_json }
            put :update, params: params
          end
        end
      end
    end

    context 'with invalid indentifier' do
      it 'returns an error response' do
        expect_response(:not_found) do
          params = { token: '' }
          put :update, params: params
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'with valid identifier' do
      it 'returns a success response' do
        expect_response(:no_content, content_type: nil) do
          params = { token: created_post.to_param }
          delete :destroy, params: params
        end
      end

      it 'destroys the requested post' do
        params = { token: created_post.to_param }
        expect { delete :destroy, params: params }.to change { Post.count }.by(-1)
      end
    end

    context 'with invalid identifier' do
      it 'returns an error response' do
        expect_response(:not_found) do
          params = { token: '' }
          delete :destroy, params: params
        end
      end
    end
  end
end
