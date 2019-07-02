require 'rails_helper'

RSpec.describe Nonce, type: :model do
  it { should belong_to(:user) }

  let!(:nonce) { create :nonce, value: nil, expires_at: nil }

  context 'on create' do
    it 'should populate value' do
      expect(nonce.value).to be_truthy
    end

    it 'should populate expires_at' do
      expect(nonce.expires_at).to be_truthy
    end
  end

  it '#expired?' do
    Timecop.travel Nonce::EXPIRATION_DURATION.from_now
    expect(nonce.expired?).to be_truthy
  end
end
