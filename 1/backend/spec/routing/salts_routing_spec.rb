require 'rails_helper'

RSpec.describe SaltsController, type: :routing do
  let(:existing_salt) { create :salt }
  let(:user_name) { existing_salt.user.name }
  let(:member_route) { "/users/#{user_name}/salt" }

  it 'routes to #show' do
    expect(get: member_route).to route_to('salts#show', user_name: user_name)
  end

  it 'does not route to #create' do
    expect(post: member_route).not_to be_routable
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
