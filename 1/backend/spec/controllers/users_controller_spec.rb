require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #show' do
    let(:created_user) { create :user }

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
        params = new_user.as_json.symbolize_keys.slice(:name, :email)
        post :create, params: params
      end

      it 'returns a success response' do
        expect_response(:created) { request_create }
      end

      it 'creates the requested user' do
        expect { request_create }.to change { User.count }.by(1)
      end
    end

    context 'for a user name already taken' do
      it 'returns an error response' do
        create :user, name: 'username'
        same_user = build :user, name: 'username'
        params = same_user.as_json.symbolize_keys.slice(:name, :email)
        expect_response(:unprocessable_entity) { post :create, params: params }
      end
    end

    context 'with invalid params' do
      it 'returns an error response' do
        new_user = build :user, name: '', email: ''
        params = new_user.as_json.symbolize_keys.slice(:name, :email)
        expect_response(:unprocessable_entity) { post :create, params: params }
      end
    end
  end

  describe 'PUT #password' do
    context 'with valid params' do
      let(:created_user) { create :user }

      let(:hashed_password) do
        BCrypt::Engine.hash_secret 'password', created_user.salt.value
      end
  
      let(:params) do
        nonce = created_user.create_nonce.value
        message = "#{nonce}||#{hashed_password}"
        encrypted_message = AuthServices::CipherService.encrypt message
        { name: created_user.to_param, message: encrypted_message }
      end

      it 'returns a success response' do
        expect_response(:ok) { patch :password, params: params }
      end

      # it 'updates the user password_digest' do
      #   put :password, params: params
      #   expect(created_user.reload.authenticate(hashed_password)).to be_truthy
      # end
    end

    # context 'with invalid indentifier' do
    #   it 'returns an error response' do
    #     expect_response(:not_found) do
    #       new_user = build :user
    #       params = { user_name: new_user.to_param }
    #       put :password, params: params
    #     end
    #   end
    # end

    # context 'with invalid nonce' do
    #   it 'renders an error response' do
    #     Timecop.travel Nonce::EXPIRATION_DURATION.from_now
    #     expect_response(:unauthorized) { put :password, params: params }
    #   end
    # end
  end
end
