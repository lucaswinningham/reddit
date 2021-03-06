RSpec.shared_examples 'can show' do |config = {}|
  let(:resource_sym) do
    described_class.to_s.underscore.split('_').tap(&:pop).join('_').singularize.to_sym
  end

  let(:pluralized_resource) { resource_sym.to_s.pluralize }
  let(:existing_resource) { create resource_sym }
  let(:member_route) { "/#{pluralized_resource}/#{existing_resource.to_param}" }
  let(:member_params) { { config[:param_sym] || :id => existing_resource.to_param } }

  it 'routes to #show' do
    expect(get: member_route).to route_to("#{pluralized_resource}#show", member_params)
  end
end
