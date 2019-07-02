RSpec.shared_examples 'can update' do
  let(:resource_sym) do
    described_class.to_s.underscore.split('_').tap(&:pop).join('_').singularize.to_sym
  end

  let(:pluralized_resource) { resource_sym.to_s.pluralize }
  let(:existing_resource) { create resource_sym }
  let(:member_route) { "/#{pluralized_resource}/#{existing_resource.to_param}" }
  let(:member_params) { { config[:param_sym] || :id => existing_resource.to_param } }

  it 'routes to #update via PUT' do
    expect(put: member_route).to route_to("#{pluralized_resource}#update", member_params)
  end

  it 'routes to #update via PATCH' do
    expect(patch: member_route).to route_to("#{pluralized_resource}#update", member_params)
  end
end
