require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:created_user) { create :user }

  describe 'GET #index' do
    it 'returns a success response' do
      expect_response(:ok) { get :index }
    end
  end

  describe 'GET #show' do
    context 'with valid indentifier' do
      it 'returns a success response' do
        expect_response(:ok) do
          params = { name: created_user.to_param }
          get :show, params: params
        end
      end
    end

    context 'with invalid indentifier' do
      it 'returns an error response' do
        expect_response(:not_found) do
          new_user = build :user
          params = { name: new_user.to_param }
          get :show, params: params
        end
      end
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:request_create) do
        new_user = build :user
        params = { user: new_user.as_json }
        post :create, params: params
      end

      it 'returns a success response' do
        expect_response(:created) { request_create }
      end

      it 'creates the requested user' do
        expect { request_create }.to change { User.count }.by(1)
      end
    end

    context 'with invalid params' do
      it 'returns an error response' do
        expect_response(:unprocessable_entity) do
          new_user = build :user, name: '', email: ''
          params = { user: new_user.as_json }
          post :create, params: params
        end
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid indentifier' do
      context 'with valid params' do
        let(:new_name) { 'other' }
        let(:new_email) { 'other@email.com' }
        let(:request_update) do
          user_patch = build :user, name: new_name, email: new_email
          params = { name: created_user.to_param, user: user_patch.as_json }
          put :update, params: params
        end

        it 'returns a success response' do
          expect_response(:ok) { request_update }
        end

        it 'updates the requested user' do
          request_update

          created_user.reload
          assert_equal new_name, created_user.name
          assert_equal new_email, created_user.email
        end
      end

      context 'with invalid params' do
        it 'returns an error response' do
          expect_response(:unprocessable_entity) do
            user_patch = build :user, name: '', email: ''
            params = { name: created_user.to_param, user: user_patch.as_json }
            put :update, params: params
          end
        end
      end
    end

    context 'with invalid indentifier' do
      it 'returns an error response' do
        expect_response(:not_found) do
          new_user = build :user
          params = { name: new_user.to_param }
          put :update, params: params
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'with valid identifier' do
      it 'returns a success response' do
        expect_response(:no_content, content_type: nil) do
          params = { name: created_user.to_param }
          delete :destroy, params: params
        end
      end

      it 'destroys the requested user' do
        params = { name: created_user.to_param }
        expect { delete :destroy, params: params }.to change { User.count }.by(-1)
      end
    end

    context 'with invalid identifier' do
      it 'returns an error response' do
        expect_response(:not_found) do
          new_user = build :user
          params = { name: new_user.to_param }
          delete :destroy, params: params
        end
      end
    end
  end
end
