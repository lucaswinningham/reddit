require 'rails_helper'

RSpec.describe NoncesController, type: :controller do
  describe 'POST #create' do
    it 'returns a success response' do
      user = create :user
      params = { user_name: user.to_param }
      expect_response(:created) { post :create, params: params }
    end

    context 'with invalid user name' do
      it 'renders an error response' do
        new_user = build :user
        invalid_params = { user_name: new_user.to_param }
        expect_response(:not_found) { post :create, params: invalid_params }
      end
    end
  end
end
