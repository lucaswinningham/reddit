require 'rails_helper'

RSpec.describe SubsController, type: :controller do
  let(:created_sub) { create :sub }

  describe 'GET #index' do
    it 'returns a success response' do
      expect_response(:ok) { get :index }
    end
  end

  describe 'GET #show' do
    context 'with valid indentifier' do
      it 'returns a success response' do
        expect_response(:ok) do
          params = { name: created_sub.to_param }
          get :show, params: params
        end
      end
    end

    context 'with invalid indentifier' do
      it 'returns an error response' do
        expect_response(:not_found) do
          new_sub = build :sub
          params = { name: new_sub.to_param }
          get :show, params: params
        end
      end
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:request_create) do
        new_sub = build :sub
        params = { sub: new_sub.as_json }
        post :create, params: params
      end

      it 'returns a success response' do
        expect_response(:created) { request_create }
      end

      it 'creates the requested sub' do
        expect { request_create }.to change { Sub.count }.by(1)
      end
    end

    context 'with invalid params' do
      it 'returns an error response' do
        expect_response(:unprocessable_entity) do
          new_sub = build :sub, name: ''
          params = { sub: new_sub.as_json }
          post :create, params: params
        end
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid indentifier' do
      context 'with valid params' do
        let(:new_name) { 'other' }
        let(:request_update) do
          sub_patch = build :sub, name: new_name
          params = { name: created_sub.to_param, sub: sub_patch.as_json }
          put :update, params: params
        end

        it 'returns a success response' do
          expect_response(:ok) { request_update }
        end

        it 'updates the requested sub' do
          request_update

          created_sub.reload
          assert_equal new_name, created_sub.name
        end
      end

      context 'with invalid params' do
        it 'returns an error response' do
          expect_response(:unprocessable_entity) do
            sub_patch = build :sub, name: ''
            params = { name: created_sub.to_param, sub: sub_patch.as_json }
            put :update, params: params
          end
        end
      end
    end

    context 'with invalid indentifier' do
      it 'returns an error response' do
        expect_response(:not_found) do
          new_sub = build :sub
          params = { name: new_sub.to_param }
          put :update, params: params
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'with valid identifier' do
      it 'returns a success response' do
        expect_response(:no_content, content_type: nil) do
          params = { name: created_sub.to_param }
          delete :destroy, params: params
        end
      end

      it 'destroys the requested sub' do
        params = { name: created_sub.to_param }
        expect { delete :destroy, params: params }.to change { Sub.count }.by(-1)
      end
    end

    context 'with invalid identifier' do
      it 'returns an error response' do
        expect_response(:not_found) do
          new_sub = build :sub
          params = { name: new_sub.to_param }
          delete :destroy, params: params
        end
      end
    end
  end
end
