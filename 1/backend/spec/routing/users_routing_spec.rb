require 'rails_helper'

RSpec.describe UsersController, type: :routing do
  let(:existing_user) { create :user }

  let(:collection_route) { '/users' }

  let(:member_route) { "/users/#{existing_user.to_param}" }
  let(:member_params) { { name: existing_user.to_param } }

  # let(:collection_route) { "/users" }

  it 'does not route to #index' do
    expect(get: collection_route).not_to be_routable
  end

  it 'routes to #show' do
    expect(get: member_route).to route_to('users#show', member_params)
  end

  it 'routes to #create' do
    expect(post: collection_route).to route_to('users#create')
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

  it 'routes to #password via PUT' do
    expect(put: "#{member_route}/password").to route_to('users#password', member_params)
  end

  it 'routes to #password via PATCH' do
    expect(patch: "#{member_route}/password").to route_to('users#password', member_params)
  end
end
