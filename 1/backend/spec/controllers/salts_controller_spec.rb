require 'rails_helper'

RSpec.describe SaltsController, type: :controller do
  describe 'GET #show' do
    let(:created_salt) { create :salt }

    it 'returns a success response' do
      user = create :user
      params = { user_name: user.to_param }
      expect_response(:ok) { get :show, params: params }
    end

    context 'with invalid user name' do
      it 'renders an error response' do
        new_user = build :user
        invalid_params = { user_name: new_user.to_param }
        expect_response(:not_found) { get :show, params: invalid_params }
      end
    end
  end
end
