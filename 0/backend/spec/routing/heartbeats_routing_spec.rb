require 'rails_helper'

RSpec.describe HeartbeatsController, type: :routing do
  describe 'routing' do
    it 'routes to #show' do
      expect(get: '/heartbeat').to route_to('heartbeats#show')
    end
  end
end
