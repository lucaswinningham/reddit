RSpec.shared_examples 'a voteable' do
  let(:model) { described_class }
  let(:model_sym) { model.to_s.underscore.to_sym }
  let(:resource) { create model_sym, up_votes_count: nil, dn_votes_count: nil }

  context 'on create' do
    it 'should initialize up_votes_count and dn_votes_count' do
      expect(resource.up_votes_count).to be(0)
      expect(resource.dn_votes_count).to be(0)
    end
  end

  it 'should increment up_votes' do
    expect { resource.inc_up_votes }.to change { resource.up_votes_count }.by(1)
  end

  it 'should decrement up_votes' do
    expect { resource.dec_up_votes }.to change { resource.up_votes_count }.by(-1)
  end

  it 'should increment dn_votes' do
    expect { resource.inc_dn_votes }.to change { resource.dn_votes_count }.by(1)
  end

  it 'should decrement dn_votes' do
    expect { resource.dec_dn_votes }.to change { resource.dn_votes_count }.by(-1)
  end
end
