RSpec.shared_examples 'can index' do
  let(:resource_sym) do
    described_class.to_s.underscore.split('_').tap(&:pop).join('_').singularize.to_sym
  end

  let(:pluralized_resource) { resource_sym.to_s.pluralize }
  let(:collection_route) { "/#{pluralized_resource}" }

  it 'routes to #index' do
    expect(get: collection_route).to route_to("#{pluralized_resource}#index")
  end
end
