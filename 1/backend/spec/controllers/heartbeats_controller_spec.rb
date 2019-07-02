require 'rails_helper'

RSpec.describe HeartbeatsController, type: :controller do
  describe 'GET #show' do
    it 'returns a success response' do
      expect_response(:no_content, content_type: nil) { get :show }
    end
  end
end
