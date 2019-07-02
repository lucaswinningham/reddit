require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'POST #create' do
    let(:default_password) { 'secret_password' }

    let!(:created_user) do
      user = create :user
      user.create_nonce
      user.password = default_password
      user.tap(&:save)
    end

    let(:params) do
      hashed_password = BCrypt::Engine.hash_secret default_password, created_user.salt.value
      message = "#{created_user.nonce.value}||#{hashed_password}"
      encrypted_message = AuthServices::CipherService.encrypt message
      { user_name: created_user.to_param, message: encrypted_message }
    end

    context 'with valid params' do
      it 'returns a success response' do
        expect_response(:created) { post :create, params: params }
      end

      it 'destroys the user nonce' do
        expect { post :create, params: params }.to change { Nonce.count }.by(-1)
      end
    end

    context 'with invalid user name' do
      it 'renders an error response' do
        new_user = build :user
        invalid_params = params.merge(user_name: new_user.to_param)
        expect_response(:not_found) { post :create, params: invalid_params }
      end
    end

    context 'with invalid nonce' do
      it 'renders an error response' do
        Timecop.travel Nonce::EXPIRATION_DURATION.from_now
        expect_response(:unauthorized) { post :create, params: params }
      end
    end

    context 'with invalid password' do
      it 'renders an error response' do
        created_user.tap { |u| u.password = 'different_password' }.save
        expect_response(:unauthorized) { post :create, params: params }
      end
    end
  end
end
