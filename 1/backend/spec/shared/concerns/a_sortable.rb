RSpec.shared_examples 'a sortable' do
  let(:model) { described_class }
  let(:model_sym) { model.to_s.underscore.to_sym }

  it 'should sort collection' do
    resources_up_votes = [1, 2, 3]
    resources_dn_votes = [4, 6, 5]
    resources = resources_up_votes.zip(resources_dn_votes).map do |up_votes, dn_votes|
      create(model_sym).tap do |resource|
        resource.update up_votes_count: up_votes
        resource.update dn_votes_count: dn_votes
      end
    end

    expected_id_order = [resources.third.id, resources.first.id, resources.second.id]
    expect(model.sort.pluck(:id)).to eq(expected_id_order)
  end
end
