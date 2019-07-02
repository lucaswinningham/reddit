RSpec.shared_examples 'an activatable' do
  let(:model) { described_class }
  let(:model_sym) { model.to_s.underscore.to_sym }

  describe 'active' do
    context 'on create' do
      it 'should be true' do
        resource = create model_sym, active: nil
        expect(resource.active).to be true
      end
    end
  end
end
