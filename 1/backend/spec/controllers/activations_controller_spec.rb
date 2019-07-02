require 'rails_helper'

RSpec.describe ActivationsController, type: :controller do
  describe 'POST #create' do
    let(:created_activation) do
      create :activation
    end

    let(:hashed_password) do
      BCrypt::Engine.hash_secret 'password', created_activation.user.salt.value
    end

    let!(:params) do
      nonce = created_activation.user.create_nonce.value
      token = created_activation.token
      message = "#{nonce}||#{token}||#{hashed_password}"
      encrypted_message = AuthServices::CipherService.encrypt message
      { user_name: created_activation.user.to_param, message: encrypted_message }
    end

    context 'with valid params' do
      it 'returns a success response' do
        expect_response(:created) { put :update, params: params }
      end

      it 'destroys the user activation' do
        expect { put :update, params: params }.to change { Activation.count }.by(-1)
      end

      it 'updates the user password_digest' do
        put :update, params: params
        authentication = created_activation.user.reload.authenticate hashed_password
        expect(authentication).to be_truthy
      end
    end

    context 'with invalid user name' do
      it 'renders an error response' do
        new_user = build :user
        invalid_params = params.merge(user_name: new_user.to_param)
        expect_response(:not_found) { put :update, params: invalid_params }
      end
    end

    context 'with invalid nonce' do
      it 'renders an error response' do
        Timecop.travel Nonce::EXPIRATION_DURATION.from_now
        expect_response(:unauthorized) { put :update, params: params }
      end
    end

    context 'with invalid token' do
      it 'renders an error response' do
        user = created_activation.user
        user.activation.destroy && user.create_activation
        expect_response(:unauthorized) { put :update, params: params }
      end
    end
  end
end
