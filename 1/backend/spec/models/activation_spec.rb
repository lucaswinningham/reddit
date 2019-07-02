require 'rails_helper'

RSpec.describe Activation, type: :model do
  it { should belong_to(:user) }

  describe 'digest' do
    context 'on create' do
      it 'should populate' do
        activation = create :activation, digest: nil
        expect(activation.digest).to be_truthy
      end
    end
  end

  describe '#token' do
    context 'on create' do
      it 'should exist' do
        activation = create :activation, digest: nil
        expect(activation.token).to be_truthy
      end

      it 'should match digest' do
        activation = create :activation, digest: nil
        expect(BCrypt::Password.new(activation.digest).is_password?(activation.token)).to be true
      end
    end
  end

  describe '#authenticate' do
    it 'should return a truthy value for correct token' do
      activation = create :activation
      expect(activation.authenticate(activation.token)).to be_truthy
    end

    it 'should return a falsy value for incorrect token' do
      activation = create :activation
      expect(activation.authenticate('bogus')).to be_falsy
    end
  end
end
