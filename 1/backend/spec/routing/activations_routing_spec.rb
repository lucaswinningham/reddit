require 'rails_helper'

RSpec.describe ActivationsController, type: :routing do
  let(:existing_activation) { create :activation }
  let(:user_name) { existing_activation.user.name }
  let(:member_route) { "/users/#{user_name}/activation" }

  it 'does not route to #show' do
    expect(get: member_route).not_to be_routable
  end

  it 'routes to #update via PUT' do
    expect(put: member_route).to route_to('activations#update', user_name: user_name)
  end

  it 'routes to #update via PATCH' do
    expect(patch: member_route).to route_to('activations#update', user_name: user_name)
  end

  it 'does not route to #destroy' do
    expect(delete: member_route).not_to be_routable
  end
end
