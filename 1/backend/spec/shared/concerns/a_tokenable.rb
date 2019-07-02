RSpec.shared_examples 'a tokenable' do
  let(:model) { described_class }
  let(:model_sym) { model.to_s.underscore.to_sym }

  describe 'token' do
    context 'on create' do
      it 'should populate' do
        resource = create model_sym, token: nil
        expect(resource.token).to be_truthy
      end
    end
  end
end
