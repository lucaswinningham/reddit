require 'rails_helper'

RSpec.describe NoncesController, type: :routing do
  let(:existing_nonce) { create :nonce }
  let(:user_name) { existing_nonce.user.name }
  let(:member_route) { "/users/#{user_name}/nonce" }

  it 'does not route to #show' do
    expect(get: member_route).not_to be_routable
  end

  it 'routes to #create' do
    expect(post: member_route).to route_to('nonces#create', user_name: user_name)
  end

  it 'does not route to #update via PUT' do
    expect(put: member_route).not_to be_routable
  end

  it 'does not route to #update via PATCH' do
    expect(patch: member_route).not_to be_routable
  end

  it 'does not route to #destroy' do
    expect(delete: member_route).not_to be_routable
  end
end
